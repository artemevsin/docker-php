FROM php:7.1-apache

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
RUN docker-php-ext-install soap

RUN wget -q -O - https://packagecloud.io/gpg.key | sudo apt-key add - \
    && echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list \
    && sudo apt-get update \
    && sudo apt-get install blackfire-agent \
    && sudo /etc/init.d/blackfire-agent restart \
    && sudo apt-get install blackfire-php \
    && service apache2 reload