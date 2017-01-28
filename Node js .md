# Installation

```
sudo apt-get install npm

# Install & update  node via npm

sudo npm cache clean -f
sudo npm install -g n
#Here you can do: n stable for the satble version, but better choose the long term supported version: n lts
#So that you will just update modules and it will be automatically updated
sudo n lts 

#install nodemon and express globally
sudo npm install nodemon express -g 
```
#How To Set Up a Node.js Application for Production on Ubuntu 16.04
Source :https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-16-04
#PM2
```
sudo npm install -g pm2
```
##Manage Application with PM2
To start the application
```
pm2 start server.js -i <nbrede Cores> --name "Mon serveur"
# or 0 for all CPUs cores 
pm2 start server.js -i 0 --name "Mon serveur"
```
To reload with zero downtime
```
$ pm2 restart all         
```

To monitor the application
```
pm2 monit
```
To stop the application
```
pm2 kill
```


For more check the source given up and /or the pm2 --help
#Secure Node.js SSL
###How to get A+ on the SSL Labs test in node.js

var server = https.createServer({
    key: privateKey,
    cert: certificate,
    ca: certificateAuthority,
    ciphers: [
        "ECDHE-RSA-AES128-SHA256",
        "DHE-RSA-AES128-SHA256",
        "AES128-GCM-SHA256",
        "RC4",
        "HIGH",
        "!MD5",
        "!aNULL"
    ].join(':'),
}, app);
