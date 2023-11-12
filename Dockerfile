FROM composer:2.6.5

WORKDIR /app

COPY . .

RUN composer install

RUN echo APP_KEY= >> .env

RUN php artisan key:generate

EXPOSE 10000

CMD php artisan serve --port=10000 --host=0.0.0.0