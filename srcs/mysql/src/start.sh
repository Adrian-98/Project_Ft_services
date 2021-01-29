mariadb-install-db -u root
mysqld -u root & sleep 5
mysql -u root wordpress < wordpress.sql
echo "CREATE DATABASE wordpress;" | mysql -u root && \
echo "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';" | mysql -u root && \ 
echo "GRANT ALL PRIVILEGES ON * . * TO 'wordpress'@'localhost';" | mysql -u root && \
echo "FLUSH PRIVILEGES;" | mysql -u root && \
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root && \
mysql wordpress -u root --password= < wordpress.sql > hide