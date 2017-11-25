FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
        curl \
        inotify-tools \
        wget && \
    rm -rf /var/lib/apt/lists/*

    # echo 'deb http://download.videolan.org/pub/debian/stable/ /' >> \
    #     /etc/apt/sources.list && \
    # echo 'deb-src http://download.videolan.org/pub/debian/stable/ /' >> \
    #     /etc/apt/sources.list && \
    # echo 'deb http://archive.ubuntu.com/ubuntu trusty main multiverse' >> \
    #     /etc/apt/sources.list && \
    # wget -O - https://download.videolan.org/pub/debian/videolan-apt.asc | \
    #     apt-key add - && \

RUN apt-get update && \
    apt-get install -y \
        apache2 \
        flac \
        lame \
        libav-tools git \
        libavcodec-extra* \
        libfaac-dev \
        libmp3lame-dev \
        libtheora-dev \
        libvorbis-dev \
        libvpx-dev \
        php5 \
        php5-curl \
        php5-json \
        php5-mysqlnd \
        pwgen \
        vorbis-tools && \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/www/* && \
    curl https://codeload.github.com/ampache/ampache/tar.gz/3.8.3 | \
        tar xz -C /var/www/ --strip-components=1

RUN chown -R www-data:www-data /var/www

# RUN php -r "readfile('https://getcomposer.org/installer');" | php && \
#     mv composer.phar /usr/local/bin/composer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r \
        "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') \
            { echo 'Installer verified'; } \
        else \
            { echo 'Installer corrupt'; unlink('composer-setup.php'); } \
        echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin && \
    php -r "unlink('composer-setup.php');"

RUN cd /var/www && \
    php composer.phar update --prefer-source

# COPY ampache.cfg.php.dist /var/temp/ampache.cfg.php.dist
COPY 001-ampache.conf /etc/apache2/sites-available/

RUN rm -rf /etc/apache2/sites-enabled/* && \
    ln -s /etc/apache2/sites-available/001-ampache.conf \
        /etc/apache2/sites-enabled/ && \
    a2enmod rewrite

# RUN echo '30 7 * * *  www-data php /var/www/bin/catalog_update.inc' >> \
#         /etc/crontab

# VOLUME ["/media"]
# VOLUME ["/var/www/config"]
# VOLUME ["/var/www/themes"]

# COPY run.sh /

# EXPOSE 80

# CMD ["/run.sh"]
