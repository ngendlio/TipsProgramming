# Installation
Or just do 
```
sudo apt-get install npm && sudo npm cache clean -f && sudo npm install -g n && sudo n lts && sudo npm install nodemon express -g && sudo npm install -g pm2
```
```
sudo apt-get install npm

# Install & update  node via npm

sudo npm cache clean -f
sudo npm install -g n

#Here you can do: n stable for the satble version, but better choose the long term supported version: n lts
 #So that you will just update modules and it will be automatically updated
## By doing this i successfully corrected openssl vulnerable by updating it to the last version . Youhoo!
sudo n lts 

#install nodemon and express globally
sudo npm install nodemon express -g 
## Install ncu to check for updates
sudo npm install -g npm-check-updates

## to check for updates of you package.json
ncu 
## Then to upgrade you pakcages.json( modules)
ncu -u
# BOUM
```
# How To Set Up a Node.js Application for Production on Ubuntu 16.04
Source :https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-16-04
#PM2
```
sudo npm install -g pm2
// or install the lates  stable
npm install pm2@latest -g
```
# Setup startup script
Restarting PM2 with the processes you manage on server boot/reboot is critical. To solve this, just run this command to generate an active startup script:
```
 pm2 startup
 ```
## Manage Application with PM2
To start the application
```
pm2 start server.js -i <nbrede Cores> --name "Mon serveur"
# or 0 for all CPUs cores 
pm2 start server.js -i 0 --name "Mon serveur"
```
Cheatsheet PM2
```
# Fork mode
$ pm2 start app.js --name my-api # Name process

# Cluster mode
$ pm2 start app.js -i 0        # Will start maximum processes with LB depending on available CPUs
$ pm2 start app.js -i max      # Same as above, but deprecated.

# Listing

$ pm2 list               # Display all processes status
$ pm2 jlist              # Print process list in raw JSON
$ pm2 prettylist         # Print process list in beautified JSON

$ pm2 describe 0         # Display all informations about a specific process

$ pm2 monit              # Monitor all processes

# Logs

$ pm2 logs [--raw]       # Display all processes logs in streaming
$ pm2 flush              # Empty all log file
$ pm2 reloadLogs         # Reload all logs

# Actions

$ pm2 stop all           # Stop all processes
$ pm2 restart all        # Restart all processes

$ pm2 reload all         # Will 0s downtime reload (for NETWORKED apps)
$ pm2 gracefulReload all # Send exit message then reload (for networked apps)

$ pm2 stop 0             # Stop specific process id
$ pm2 restart 0          # Restart specific process id

$ pm2 delete 0           # Will remove process from pm2 list
$ pm2 delete all         # Will remove all processes from pm2 list

# Misc

$ pm2 reset <process>    # Reset meta data (restarted time...)
$ pm2 updatePM2          # Update in memory pm2
$ pm2 ping               # Ensure pm2 daemon has been launched
$ pm2 sendSignal SIGUSR2 my-app # Send system signal to script
$ pm2 start app.js --no-daemon
$ pm2 start app.js --no-vizion
$ pm2 start app.js --no-autorestart
```


For more check the source given up and /or the pm2 --help
# Secure Node.js SSL

### How to get A+ on the SSL Labs test in node.js

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
