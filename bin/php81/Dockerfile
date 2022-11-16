FROM php:8.1-apache-buster

ARG WHOAMI

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

RUN useradd -ms /bin/bash ${WHOAMI}

RUN usermod -aG sudo ${WHOAMI}
RUN adduser ${WHOAMI} www-data
RUN chown ${WHOAMI}:www-data /var/www -R
RUN echo 'alias sf="php bin/console"' >> /home/${WHOAMI}/.bashrc
RUN echo "parse_git_branch() { \n\
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' \n\
} \n\
export PS1=\"\u@\h \[\\\e[32m\]\w \[\\\e[91m\]\$(parse_git_branch)\[\\\e[00m\]$ \"" >> /home/${WHOAMI}/.bashrc