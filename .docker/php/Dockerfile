FROM php:8.3.4-cli-bookworm

ARG COMPOSER_VERSION=2.7.2
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=$COMPOSER_VERSION

RUN apt-get update \
    && apt-get install -y \
    libzmq5 libzmq5-dev \
    unzip \
    curl git iputils-ping

# zeromq from source
RUN mkdir /build \
    && cd /build \
    && git clone https://github.com/zeromq/php-zmq \
    && cd php-zmq \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable zmq

# zeromq
# RUN pecl install zmq-1.1.3 && docker-php-ext-enable zmq

#xdebug
RUN pecl install xdebug-3.3.1 && docker-php-ext-enable xdebug

WORKDIR "/app"

ARG APP_USER_ID
RUN useradd -s /bin/bash -u ${APP_USER_ID} -m appuser
USER appuser
