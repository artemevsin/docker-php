FROM php:5-apache

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
        libicu-dev \
        libzip-dev \
        libc-client-dev \
        libkrb5-dev \
        g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) iconv mcrypt intl pdo pdo_mysql mysqli mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && apt-get install imagemagick libmagickwand-dev libmagickcore-dev -y \
    && pecl install imagick

RUN pecl install xdebug-2.5.5
RUN pecl install zip
RUN docker-php-ext-install mysql
RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath
RUN apt-get install -y libpq-dev
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pgsql