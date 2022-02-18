FROM php:8.1-apache-buster

ARG GIT_EMAIL
ARG GIT_NAME

RUN apt-get update \
    &&  apt-get install -y --no-install-recommends \
        locales apt-utils git libicu-dev g++ libpng-dev libxml2-dev libzip-dev libonig-dev libxslt-dev unzip libpq-dev nodejs npm wget \
        apt-transport-https lsb-release ca-certificates

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

# Git
RUN git config --global user.email "${GIT_EMAIL}" \
    &&  git config --global user.name "${GIT_NAME}"