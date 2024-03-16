#!/bin/sh

# Path to the Icecast configuration file
path_icecast_configuration_file="/etc/icecast.xml"

# Marker file to indicate whether the block has been added
marker_file="mount_block_added"

previous_block_number="0"

xml_block=""

env_sorted=$(env | sort)

# Function to add mount blocks to XML file before </icecast> tag
add_mount_blocks() {
    # Loop through environment variables and add mount blocks
    for var in $(echo "$env_sorted" | grep '^ICECAST_MOUNT_' | cut -d= -f1); do
        block_number=$(echo "$var" | cut -d'_' -f3)
        # Extract substring after third underscore
        trimmed_var=$(echo "$var" | cut -d"_" -f4- | tr '[:upper:]' '[:lower:]' | tr '_' '-')
        xml_element=$(build_xml_element "$var")
        # Check if block_number changes and previous value is not 0
        if [ "$block_number" != "$previous_block_number" ]; then
            if [ "$previous_block_number" != "0" ]; then
                xml_block="$xml_block\t</mount>\n"  # Close the previous mount block
            fi
            xml_block="$xml_block\t<mount type=\"normal\">\n"  # Open a new mount block
        fi
        xml_block="$xml_block\t\t$xml_element\n"  # Append xml_element to xml_block with two tabs
        previous_block_number="$block_number"  # Update previous_block_number
    done

    # Append closing tag for the last mount block
    if [ "$previous_block_number" != "0" ]; then
        xml_block="$xml_block\t</mount>\n"
    fi

    # Check if the marker file exists
    if [ ! -f "$marker_file" ]; then
        # Add the mount block before the </icecast> tag
        awk -v block="$xml_block" '/<\/icecast>/ {print block} 1' "$path_icecast_configuration_file" > "$path_icecast_configuration_file.tmp" && mv "$path_icecast_configuration_file.tmp" "$path_icecast_configuration_file"
        # Create the marker file
        touch "$marker_file"
    fi
}

# Function to build XML element from environment variable name
build_xml_element() {
    local var_name="$1"
    local trimmed_var=$(echo "$var_name" | cut -d'_' -f4- | tr '[:upper:]' '[:lower:]' | tr '_' '-')
    local value=$(eval echo "\$$var_name")  # Perform variable expansion
    echo "<${trimmed_var}>${value}</${trimmed_var}>"
}

general_settings() {
    if [ -n "$ICECAST_SOURCE_PASSWORD" ]; then
        sed -i "s/<source-password>[^<]*<\/source-password>/<source-password>$ICECAST_SOURCE_PASSWORD<\/source-password>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_RELAY_PASSWORD" ]; then
        sed -i "s/<relay-password>[^<]*<\/relay-password>/<relay-password>$ICECAST_RELAY_PASSWORD<\/relay-password>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_ADMIN_PASSWORD" ]; then
        sed -i "s/<admin-password>[^<]*<\/admin-password>/<admin-password>$ICECAST_ADMIN_PASSWORD<\/admin-password>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_ADMIN_USERNAME" ]; then
        sed -i "s/<admin-user>[^<]*<\/admin-user>/<admin-user>$ICECAST_ADMIN_USERNAME<\/admin-user>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_ADMIN_EMAIL" ]; then
        sed -i "s/<admin>[^<]*<\/admin>/<admin>$ICECAST_ADMIN_EMAIL<\/admin>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_LOCATION" ]; then
        sed -i "s/<location>[^<]*<\/location>/<location>$ICECAST_LOCATION<\/location>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_HOSTNAME" ]; then
        sed -i "s/<hostname>[^<]*<\/hostname>/<hostname>$ICECAST_HOSTNAME<\/hostname>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_MAX_CLIENTS" ]; then
        sed -i "s/<clients>[^<]*<\/clients>/<clients>$ICECAST_MAX_CLIENTS<\/clients>/g" /etc/icecast.xml
    fi
    if [ -n "$ICECAST_MAX_SOURCES" ]; then
        sed -i "s/<sources>[^<]*<\/sources>/<sources>$ICECAST_MAX_SOURCES<\/sources>/g" /etc/icecast.xml
    fi
}

# Legacy replacement
general_settings

# Add mount blocks to XML file
add_mount_blocks

# Execute the CMD or whatever command is provided
exec "$@"
