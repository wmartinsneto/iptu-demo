FROM php:8.0-apache

# Instalar extensões PHP necessárias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install zip

# Habilitar mod_rewrite para URLs amigáveis
RUN a2enmod rewrite

# Configurar o Apache para permitir .htaccess
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Configurar o PHP
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Definir diretório de trabalho
WORKDIR /var/www/html

# Configurar permissões
RUN chown -R www-data:www-data /var/www/html

# Expor porta 80
EXPOSE 80
