FROM php:7-fpm-alpine

RUN \
    apk update \
    && apk add --no-cache \
    freetype-dev \
    g++ make autoconf \
    libjpeg-turbo-dev \
    libpng-dev \
    libsodium-dev \
    libwebp-dev \
    openssl-dev \

    && docker-php-ext-install zip \
    && docker-php-ext-configure opcache \
    && docker-php-ext-configure exif \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include \

    && apk add --no-cache --virtual .pecl-ext-build-deps \
    && pecl channel-update pecl.php.net \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb.so \
    && pecl install libsodium-1.0.6 \
    && docker-php-ext-enable libsodium \
    && pecl clear-cache \
    && apk del .pecl-ext-build-deps \
    && docker-php-source delete
