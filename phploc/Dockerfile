FROM php:7.2-cli

RUN curl -fSL "https://phar.phpunit.de/phploc.phar" -o "phploc.phar" \
	&& chmod +x phploc.phar \
	&& mv phploc.phar /usr/local/bin/phploc

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["phploc"]
