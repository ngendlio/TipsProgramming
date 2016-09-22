#Test your webserver to see how many rqs it can handle per sec

For that, we use the npm module `loadtest`
##Install Loadtest
```
sudo npm install loadtest
```

##Test performance
`-n` : Number of requests

`-c` : Concurrency( clients)

`-t` : Time to make tests

`-k` : Keep-alive connection: It will speed up the answers 4rm server

`--rps`: Specify the requests per seconds

`Example`:

Command: How much req /sec the web server can handle for 100 clients ?

```loadtest -c 100 -t 20   http://localhost:2016/```

Command: How much req /sec the web server can handle for 100 clients if it keep alive the connection ?

```loadtest -c 100 -t 20 -k  http://localhost:2016/```


Typical Resuslts:
```
lionel@lionel-ThinkPad-X1-Carbon:~$ loadtest -c 1000 -t 20  http://localhost:2016/ 
[Thu Sep 22 2016 21:01:18 GMT+0100 (WEST)] INFO Requests: 0, requests per second: 0, mean latency: 0 ms
[Thu Sep 22 2016 21:01:23 GMT+0100 (WEST)] INFO Requests: 0, requests per second: 0, mean latency: 0 ms
[Thu Sep 22 2016 21:01:28 GMT+0100 (WEST)] INFO Requests: 0, requests per second: 0, mean latency: 0 ms
[Thu Sep 22 2016 21:01:33 GMT+0100 (WEST)] INFO Requests: 504, requests per second: 101, mean latency: 12600 ms
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO 
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Target URL:          http://localhost:2016/
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Max time (s):        20
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Concurrency level:   1000
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Agent:               none
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO 
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Completed requests:  762
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Total errors:        0
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Total time:          20.23130505 s
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Requests per second: 38             <=============================
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Total time:          20.23130505 s
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO 
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO Percentage of the requests served within a certain time
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO   50%      12605 ms
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO   90%      15580 ms
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO   95%      15582 ms
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO   99%      15587 ms
[Thu Sep 22 2016 21:01:38 GMT+0100 (WEST)] INFO  100%      15588 ms (longest request)

```
