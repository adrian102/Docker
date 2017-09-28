FROM php:7-fpm
MAINTAINER Webiny <info@webiny.com>

# System Dependencies
RUN apt-get update && \
    apt-get install -y wget \
    libxrender1 \
    libfontconfig \
    libxext6 \
    autoconf pkg-config \
    libssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev

# wkhtml
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
    tar xf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
    cp wkhtmltox/bin/wkhtmltopdf /usr/local/bin/

# MongoDB
RUN pecl install mongodb-1.2.2 && echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini

# Image Processing
RUN docker-php-ext-install iconv mcrypt mbstring \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

WORKDIR /app
