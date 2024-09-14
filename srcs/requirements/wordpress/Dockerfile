FROM debian:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    netcat-openbsd \
    wget 

COPY ./tools/init.sh /usr/bin/init.sh

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN chmod -R 755 /usr/bin/init.sh

# Create the /var/www/html directory
RUN mkdir -p /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

#RUN wget https://wordpress.org/wordpress-6.4.tar.gz && \
#    tar -xzvf wordpress-6.4.tar.gz -C /var/www/ && \
#	rm wordpress-6.4.tar.gz
# Download and install WordPress
RUN wget https://wordpress.org/wordpress-6.4.tar.gz && \
    tar -xzvf wordpress-6.4.tar.gz -C /var/www/ && \
	rm wordpress-6.4.tar.gz


# Set permissions
#RUN chown -R www-data:www-data /var/www/wordpress \
#    && chmod -R 755 /var/www/wordpress

# Expose port 9000 for PHP-FPM
#EXPOSE 9000

# Start PHP-FPM
CMD ["/usr/bin/init.sh"]
CMD ["php-fpm8.2", "--nodaemonize"]
