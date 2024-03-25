# Use the official PHP image with Apache
FROM php:8.0-apache

# Install system dependencies
RUN apt-get update && apt-get install -y git unzip

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy existing application directory contents
COPY . /var/www/html

# Install all PHP dependencies
RUN composer install

# Expose port 80 to access web server
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
