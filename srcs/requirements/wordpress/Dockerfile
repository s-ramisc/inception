FROM debian:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    wget \
    unzip \
    && apt-get clean

COPY ./tools/init.sh /usr/bin/init.sh

RUN chmod -R 755 /usr/bin/init.sh

# Create the /var/www/html directory
RUN mkdir -p /var/www/html && \
    chmod -R 755 /var/www/html

# Download and install WordPress
RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \
    && mv wordpress /var/www/html

# Set permissions
#RUN chown -R www-data:www-data /var/www/html \
 #   && chmod -R 755 /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["/usr/bin/init.sh"]
