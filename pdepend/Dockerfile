FROM php:7.1-cli

RUN apt-get update && apt-get install -y libbz2-dev \
	&& docker-php-ext-install bz2
RUN curl -fSL "http://static.pdepend.org/php/latest/pdepend.phar" -o "pdepend.phar" \
	&& chmod +x pdepend.phar \
	&& mv pdepend.phar /usr/local/bin/pdepend

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["pdepend"]
