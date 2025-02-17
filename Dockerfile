FROM alpine:latest
LABEL maintainer "infiniteproject@gmail.com"

RUN addgroup -S icecast && \
    adduser -S icecast
    
RUN apk add --update \
        icecast \
        mailcap && \
    rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create the log directory and grant permissions to the icecast user
RUN mkdir -p /var/log/icecast && chown -R icecast:icecast /var/log/icecast

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
CMD icecast -c /etc/icecast.xml
