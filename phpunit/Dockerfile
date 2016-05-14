FROM php:7.0-cli

RUN apt-get update && apt-get install -y libxml2-dev \
	&& docker-php-ext-install xmlwriter
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug
RUN docker-php-ext-install pcntl tokenizer
RUN curl -fSL "https://phar.phpunit.de/phpunit.phar" -o "phpunit.phar" \
	&& chmod +x phpunit.phar \
	&& mv phpunit.phar /usr/local/bin/phpunit

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["phpunit"]
