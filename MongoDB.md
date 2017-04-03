# Install Mongo DB
```
sudo apt-get install mongodb-server
```
# Configure MongoDB username and password
## Open mongo Shell and connect to admin DB
```
mongo
use admin
```
## Create user  with root privileges
```
#ADMIN
db.createUser({user:"lio_Mongo", pwd:"admin123", roles:[{role:"root", db:"admin"}]})

#
```
Then save and exit.
## Enable mongodb authentication

Edit the file  `lib/systemd/system/mongodb.service` or  `\lib/systemd/system/mongod.service`
depending on the one that is not empty
-  Change  `ExecStart=/usr/bin/mongod  --config /etc/mongod.conf`
- To `ExecStart=/usr/bin/mongod --quiet --auth --config /etc/mongod.conf`

Then reload  the systemd service:
```
 systemctl daemon-reload
```
##  Restart MongoDB
```
sudo service mongod restart
```

## How to connect to DB in MONGO DB
 ```
 mongo -u lio_Mongo -p admin123 --authenticationDatabase admin
 ```
 # Drop databse in mongo DB 
 ```
 use DB_NAME
 // but make a test first to be sure it wont erase all DBs
 db.dropDatabase();
 ```
# Transactions in Mongo DB
It is simple haha.

Just create a collection called TRANSACTIONS in which you will store the old values of the 2 doc that will be updated.

And then,just follwo these steps:

1) Update the transaction to state: initial
2) Update the first doc (B)
3) Update the second doc (A)
4) Set the transaction to state: finished

And when the application start check before everything else

- If state= initial, just rollback all the doc A and doc B with the old values
- If state = finished, then remove this doc transaction from the TRANSACTION Collection


