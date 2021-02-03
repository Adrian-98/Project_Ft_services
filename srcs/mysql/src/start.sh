# mariadb-install-db -u root
# mysqld -u root & sleep 5
# echo "CREATE DATABASE wordpress;" | mysql -u root && \
# mysql -u root wordpress < wordpress.sql
# echo "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';" | mysql -u root && \ 
# echo "GRANT ALL PRIVILEGES ON * . * TO 'wordpress'@'localhost';" | mysql -u root && \
# echo "FLUSH PRIVILEGES;" | mysql -u root && \
# echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root && \
# mysql wordpress -u root --password= < wordpress.sql > hide

#! /bin/sh

# Install MariaDB database(mariadb-install-db is a symlink to mysql_install_db).
mariadb-install-db -u root

# Invoking "mysqld" will start the MySQL server. Terminating "mysqld" will shutdown the MySQL server.
mysqld -u root & sleep 5

mysql << EOF 

# Create Wordpress database.
mysql -u root --execute="CREATE DATABASE wordpress;"

# Import previously backed up database to MariaDB database server (wordpress < /wordpress.sql).

# Create new user "root" with password "toor" and give permissions.
mysql -u root --execute="CREATE USER 'root'@'%' IDENTIFIED BY 'toor'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"
EOF

mysql -u root wordpress < wordpress.sql
# Start Telegraf and sleep infinity for avoid container to stop.
# telegraf & sleep infinite

mysql -u root -p