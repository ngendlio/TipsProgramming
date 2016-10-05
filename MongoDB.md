#Install Mongo DB
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
db.createUser({user:"lio_Mongo", pwd:"admin123", roles:[{role:"root", db:"admin"}]})
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

# How to connect to DB in MONGO DB
 ```
 mongo -u lio_Mongo -p admin123 --authenticationDatabase admin

 ```




`To be continued`
