FROM php:7.3-apache
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        gnupg \
        apt-transport-https \
        zip \
        libxrender1 \
        libfontconfig1 \
        libxtst6 \
        libcurl4-openssl-dev \
        pkg-config \
        libssl-dev \
        libzip-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install bcmath \
    && docker-php-ext-enable bcmath \
    && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl https://phar.phpunit.de/phpunit.phar --output phpunit.phar -L
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit

RUN a2enmod rewrite

COPY php.ini /usr/local/etc/php/

