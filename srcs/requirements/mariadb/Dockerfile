# Use the official Debian image as the base
FROM debian:bullseye-slim

# Install MariaDB server and necessary packages
RUN apt-get update && \
    apt-get install -y \
    mariadb-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom MariaDB configuration file
COPY conf/my.cnf /etc/mysql/my.cnf

# Make sure init.sh is executable
# COPY conf/init.sh .
# RUN chmod 777 init.sh

# Expose port 3306 for MariaDB
EXPOSE 3306

# Start MariaDB service
CMD ["/init.sh"]
CMD ["mysqld_safe"]


