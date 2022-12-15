FROM nginx:1.23

USER root

RUN apt-get update && \
    apt-get -y install \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | \
    tee /etc/apt/sources.list.d/php.list && \
    apt-get update

RUN apt-get install -y \
    php8.1-fpm \
    php8.1-curl \
    php8.1-xml \
    php8.1-gd \
    php8.1-pgsql \
    php8.1-xdebug \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /etc/php/8.1/fpm/php.ini
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/php

EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]
