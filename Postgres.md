# Install postgres

`sudo apt update`
`sudo apt install postgresql postgresql-contrib`

## Configure Postgres
```
sudo -u postgres psql
postgres=# create database mydb;
postgres=# create user myuser with encrypted password 'mypass';
postgres=# grant all privileges on database mydb to myuser;
```

### change Password of a user
```
alter user <username> with encrypted password '<password>';
```
