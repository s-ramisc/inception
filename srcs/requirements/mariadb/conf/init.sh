#!/bin/sh

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql 

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
    /etc/init.d/mariadb setup
fi

sleep 10

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
    mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;"
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "CREATE USER IF NOT EXISTS $MYSQL_USER@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO $MYSQL_USER@'localhost' WITH GRANT OPTION;"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';"
    mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

fi