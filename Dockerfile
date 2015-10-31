FROM alpine:latest
ENV APTLIST="bash curl git php-cli php-json php-curl php-phar php-openssl php-xml php-dom"
ENV EMAIL = ""
ENV PASSWORD = ""
ENV COMPOSER_HOME="/app"

ADD start.sh /start.sh

# Make directory
RUN mkdir -p /app /downloads && \
# Install and update
	apk update && \
	apk upgrade	&& \
	apk add --update $APTLIST && \
	curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /bin/composer && \
# Install laravel downloader
	git clone https://github.com/iamfreee/laracasts-downloader.git /app && \
	cd /app && \
	composer install && \
	mv /app/config.example.ini /app/config.ini && \
	chmod +x /start.sh && \
	rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

VOLUME /downloads

ENTRYPOINT ["/start.sh"]