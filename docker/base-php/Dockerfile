FROM ubuntu:16.04

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > \
        /etc/apt/sources.list.d/ondrej-php.list \
    && echo "deb http://ppa.launchpad.net/ondrej/php-qa/ubuntu xenial main" > \
        /etc/apt/sources.list.d/ondrej-php-qa.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install curl ca-certificates \
        php7.1-cli php7.1-common php7.1-curl php7.1-mbstring \
        php7.1-dev php7.1-json php7.1-pgsql php7.1-odbc php7.1-opcache \
        php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip php7.1-xdebug php7.1-sqlite \
    && curl -sS https://getcomposer.org/installer | \
        php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer

CMD ["php", "-a"]

WORKDIR /app

ADD . /app
