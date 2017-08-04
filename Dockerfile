FROM php:7-fpm-alpine

RUN apk update
RUN apk add --no-cache --virtual .ext-deps \
    libjpeg-turbo-dev \
    libwebp-dev \
    libpng-dev \
    freetype-dev \
    libmcrypt \
    libmcrypt-dev \
    g++ make autoconf

RUN \
    docker-php-ext-configure opcache && \
    docker-php-ext-configure exif && \
    docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include && \
    docker-php-ext-configure mcrypt

# Mongo Installation
RUN \
    apk add --no-cache --virtual .mongodb-ext-build-deps openssl-dev && \
    pecl install mongodb && \
    pecl clear-cache && \
    apk del .mongodb-ext-build-deps

RUN \
    docker-php-ext-enable mongodb.so && \
    docker-php-source delete
