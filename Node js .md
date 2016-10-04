# Installation

```
sudo apt-get install npm

# Install & update  node via npm

sudo npm cache clean -f
sudo npm install -g n
sudo n stable

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
