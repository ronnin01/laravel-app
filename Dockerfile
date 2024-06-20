FROM php:8-fpm

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    rsync \
    && rm -rf /var/lib/apt/lists/ \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

RUN groupadd -g 1000 appuser && useradd -u 1000 -ms /bin/bash -g appuser appuser

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

RUN chown -R appuser:appuser /var/www

USER appuser

RUN composer install --no-dev

RUN chown -R www-data:www-data /var/www/html/bootstrap/cache

RUN chown -R www-data:www-data /var/www/html/storage

RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 9000

CMD php-fpm
