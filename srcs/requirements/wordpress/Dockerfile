FROM debian:bullseye

ENV PHP_VERSION=7.4 \
    WORDPRESS_VERSION=6.3.2

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        php${PHP_VERSION} \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-zip \
        mariadb-client \
        curl \
        unzip && \
    apt-get clean

RUN mkdir -p /run/php && \
    sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

WORKDIR /var/www/html
RUN curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz" && \
    tar -xzf wordpress.tar.gz --strip-components=1 && \
    rm wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html

COPY tools/wordpress_setup.sh /usr/local/bin/wordpress_setup.sh
RUN chmod +x /usr/local/bin/wordpress_setup.sh

EXPOSE 9000

VOLUME ["/var/www/html"]

ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]

# Change version if ever you change PHP_VERSION
# (I don't use the variable because I'm not alowed to..)
CMD ["php-fpm7.4", "-F"]