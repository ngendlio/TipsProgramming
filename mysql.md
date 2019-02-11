# Reset forgotten password for Root

> sudo service mysql stop
> sudo mysqld_safe --skip-grant-tables &
 Now, open another tab without closing this one.
> mysql -u root
mysql> use mysql;
mysql> update user set authentication_string=password('super-secure') where user='root';

mysql> flush privileges;
mysql> quit
