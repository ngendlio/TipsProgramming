#Install High performance REDIS
To install it 
```
sudo apt-get install redis-server
```

## Set up a password
Edit the `/etc/redis/redis.conf`
Search the word `requirepass` and set the password you want.
#Reload REDIS

```
sudo service redis-server restart
```

# Security is important in REDIS :
Check on the website of REDIS !!
And you are done.
