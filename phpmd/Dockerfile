FROM php:7.2-cli

RUN apt-get update && apt-get install -y libbz2-dev \
	&& docker-php-ext-install bz2
RUN curl -fSL "http://static.phpmd.org/php/latest/phpmd.phar" -o "phpmd.phar" \
	&& chmod +x phpmd.phar \
	&& mv phpmd.phar /usr/local/bin/phpmd

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["phpmd"]
