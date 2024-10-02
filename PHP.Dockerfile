FROM ubuntu:latest
FROM node:latest
FROM php:fpm

RUN apt-get update && apt-get upgrade -y

# Prepare the image with the required packages and extensions
RUN apt-get install -y git libcurl4-openssl-dev curl libbz2-dev libzip-dev libxml2-dev libonig-dev libpng-dev python3.11-full libjpeg-dev libgd-dev libmagickwand-dev unzip 7zip libpq-dev
RUN docker-php-ext-install pdo pdo_mysql curl bz2 zip intl mbstring bcmath gd pdo_pgsql

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN mkdir -p /usr/src/php/ext/imagick \
  && curl -fsSL https://github.com/Imagick/imagick/archive/944b67fce68bcb5835999a149f917670555b6fcb.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1 \
  && docker-php-ext-install imagick
# RUN pecl install imagick && docker-php-ext-enable imagick

# Let us include composer for php
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Make sure we have nodejs available
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

WORKDIR /app/www