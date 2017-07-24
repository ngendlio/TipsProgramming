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
## Use redis as a caching system
We can speed up to 99 % the response time of our API by using REDIS in the cache response...

Check this code
-----------
```
// if a user visits /api/facebook, return the total number of stars 'facebook'
// has across all it's public repositories on GitHub
app.get('/api/:username', function(req, res) {
  // get the username parameter in the URL
  // i.e.: username = "coligo-io" in http://localhost:5000/api/coligo-io
  var username = req.params.username;

  // use the redis client to get the total number of stars associated to that
  // username from our redis cache
  client.get(username, function(error, result) {

      if (result) {
        // the result exists in our cache - return it to our user immediately
        res.send({ "totalStars": result, "source": "redis cache" });
      } else {
        // we couldn't find the key "coligo-io" in our cache, so get it
        // from the GitHub API
        getUserRepositories(username)
          .then(computeTotalStars)
          .then(function(totalStars) {
            // store the key-value pair (username:totalStars) in our cache
            // with an expiry of 1 minute (60s)
            client.setex(username, 60, totalStars);
            // return the result to the user
            res.send({ "totalStars": totalStars, "source": "GitHub API" });
          }).catch(function(response) {
            if (response.status === 404){
              res.send('The GitHub username could not be found. Try "coligo-io" as an example!');
            } else {
              res.send(response);
            }
          });
      }

  });
});
```

## Use REDIS as a caching system
##### Storing Strings
```
client.set('framework', 'AngularJS', (err, reply)=>{
  console.log(reply);
});
```
##### Storing objects
```
client.hmset('frameworks', OBJECT);
```
##### Storing lists
```
client.rpush(['frameworks', 'angularjs', 'backbone'], function(err, reply) {
    console.log(reply);
});
//To retrieve the elements of tTo retrieve the elements of the list you can use the lrange() function as following:
client.lrange('frameworks', 0, -1, function(err, reply) {
    console.log(reply); // ['angularjs', 'backbone']
});
```
##### Storing Sets (similar to lists, but the difference is that they don’t allow duplicates)
```
client.sadd(['tags', 'angularjs', 'backbonejs', 'emberjs'], function(err, reply) {
    console.log(reply); // 3
});
//As you can see, the sadd() function creates a new set with the specified elements. 
//Here, the length of the set is three. To //retrieve the members of the set, use the smembers() function as following:

client.smembers('tags', function(err, reply) {
    console.log(reply);
});
```
##### Checking the Existence of Keys
Sometimes you may need to check if a key already exists and proceed accordingly. To do so you can use exists() function as shown below:
```
client.exists('key', function(err, reply) {
    if (reply === 1) {
        console.log('exists');
    } else {
        console.log('doesn\'t exist');
    }
});
```
##### Deleting and Expiring Keys
At times you will need to clear some keys and reinitialize them. To clear the keys, you can use del command as shown below:
```
client.del('frameworks', function(err, reply) {
    console.log(reply);
});
```
You can also give an expiration time to an existing key as following:
```
client.set('key1', 'val1');
client.expire('key1', 30);
```
The above snippet assigns an expiration time of 30 seconds to the key key1.

##### Incrementing and Decrementing
Redis also supports incrementing and decrementing keys. To increment a key use incr() function as shown below:
```
client.set('key1', 10, function() {
    client.incr('key1', function(err, reply) {
        console.log(reply); // 11
    });
});
```
