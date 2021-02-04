
mariadb-install-db -u root

mysqld -u root & sleep 5

mysql << EOF 

# Create Wordpress database.
mysql -u root --execute="CREATE DATABASE wordpress;"

# Import previously backed up database to MariaDB database server (wordpress < /wordpress.sql).

# Create new user "root" with password "toor" and give permissions.
mysql -u root --execute="CREATE USER 'root'@'%' IDENTIFIED BY 'toor'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"

EOF

mysql -u root wordpress < wordpress.sql


mysql -u root -p