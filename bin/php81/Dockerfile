FROM php:8.1-apache-buster

ARG WHO_AM_I

RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    &&  apt-get install -y --no-install-recommends \
        locales apt-utils git libicu-dev g++ libpng-dev libxml2-dev libzip-dev libonig-dev libxslt-dev unzip libpq-dev wget \
        apt-transport-https lsb-release ca-certificates \
    && apt-get install sudo \
    && apt-get install -y vim

RUN curl -sS https://getcomposer.org/installer | php -- \
    &&  mv composer.phar /usr/local/bin/composer

# Other PHP EXT
RUN docker-php-ext-configure \
            intl \
    &&  docker-php-ext-install \
            pdo pdo_mysql pdo_pgsql opcache intl zip calendar dom mbstring gd xsl

RUN pecl install apcu && docker-php-ext-enable apcu

# Enable apache modules
RUN a2enmod rewrite headers
# Prepare fake SSL certificate
RUN apt-get update
RUN apt-get install -y ssl-cert

# Setup Apache2 mod_ssl
RUN a2enmod ssl
# Setup Apache2 HTTPS env
RUN a2ensite default-ssl.conf

# Cleanup
RUN rm -rf /usr/src/*
RUN echo 'alias sf="php bin/console"' >> ~/.bashrc