FROM php:7.2-cli

RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug
RUN apt-get update && apt-get install -y libxml2-dev \
	&& docker-php-ext-install xmlwriter
RUN docker-php-ext-install pcntl
RUN curl -fSL "https://phar.phpunit.de/phpunit.phar" -o "phpunit.phar" \
	&& chmod +x phpunit.phar \
	&& mv phpunit.phar /usr/local/bin/phpunit

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["phpunit"]
