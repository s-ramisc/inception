#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

mysqld_safe --skip-networking &
sleep 5  # Give it a few seconds to start

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
    mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;"
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "CREATE USER IF NOT EXISTS $MYSQL_USER@'$DOMAIN_NAME' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO $MYSQL_USER@'$DOMAIN_NAME' WITH GRANT OPTION;"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';"
    mysql -uroot -e "ALTER USER 'root'@'$DOMAIN_NAME' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

fi
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

exec mysqld_safe 