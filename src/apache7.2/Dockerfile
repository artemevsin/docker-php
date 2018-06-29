FROM php:7.2-apache

RUN a2enmod rewrite \
    && apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libicu-dev \
        libzip-dev \
        libc-client-dev \
        libkrb5-dev \
        g++ \
        imagemagick \
        libmagickwand-dev \
        libmagickcore-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) iconv intl pdo pdo_mysql mysqli mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-install opcache \
    && apt-get install  -y \
    && pecl install imagick \
    && pecl install mcrypt-1.0.1 \
    && pecl install xdebug-2.6.0 \
    && pecl install zip \
    && docker-php-ext-install soap \
    && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini