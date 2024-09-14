FROM debian:latest

RUN apt-get update && \
    apt-get install -y nginx openssl

# Directory for SSL certificates
RUN mkdir /etc/nginx/certs

# Copy NGINX configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

# Generate a self-signed SSL certificate
RUN openssl genrsa -out /etc/nginx/certs/server.key 2048 && \
    openssl req -new -x509 -key /etc/nginx/certs/server.key -out /etc/nginx/certs/server.crt -days 365 -subj "/CN=sramis-c.42.fr"

# Expose port 443 for HTTPS
#EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]