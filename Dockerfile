FROM php:7
RUN apt-get update -y && apt-get install -y openssl zip unzip git
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo pdo_mysql
WORKDIR /var/www
COPY composer.json /var/www
COPY composer.lock /var/www
RUN composer install --no-scripts --no-autoloader --no-interaction --no-progress
RUN php artisan key:generate
COPY . /var/www
RUN composer dump-autoload --optimize
CMD php artisan serve --host=0.0.0.0 --port=8000
EXPOSE 8000