ARG BASE_IMAGE
FROM php:$BASE_IMAGE

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libicu-dev libpq-dev libonig-dev libmcrypt-dev zlib1g-dev libzip-dev libmagickwand-dev libsodium-dev libpng-dev  \
        openssh-client git zip unzip \
    && rm -r /var/lib/apt/lists/*

RUN pecl install imagick xdebug \
    && docker-php-ext-enable imagick xdebug \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && docker-php-ext-install intl mbstring pcntl pdo_mysql pdo_pgsql pgsql zip opcache bcmath sodium sockets gd

RUN curl -sS https://getcomposer.org/installer | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_MEMORY_LIMIT 0
