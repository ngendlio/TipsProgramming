# Installation

```
sudo apt-get install node npm

# Install & update  node via npm

sudo npm cache clean -f
sudo npm install -g n
sudo n stable

#install nodemon and express globally
sudo npm install nodemon express -g 
```
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
