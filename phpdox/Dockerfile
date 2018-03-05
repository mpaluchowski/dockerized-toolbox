FROM php:7.2-cli

RUN apt-get update && apt-get install -y libxslt-dev \
	&& docker-php-ext-install xsl
RUN curl -fSL "http://phpdox.de/releases/phpdox.phar" -o "phpdox.phar" \
	&& chmod +x phpdox.phar \
	&& mv phpdox.phar /usr/local/bin/phpdox

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["phpdox"]
