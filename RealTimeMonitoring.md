# Configurer Inotify on Linux Systems

## Installer inotify-tools

```
sudo apt-get install inotify-tools
```
## Watch one time exit

```
inotifywait  /home/lionel/Documents
```
`Ps`: You will notice that   inotifywait is a blocking program, and one thing you have to know is that it does not consume cpu or 
RAM when waiting. It will be called by the kernel.

## Watch folders and files continusly

Create a bash file and put this code inside of it:

```
while true #run indefinitely
do 
inotifywait -r -e modify,attrib,close_write,move,create,delete /home/lionel/Documents
done
```
## Watch and log all activities 

Just add  the logger program after an event, then the event will go directly to the syslog program,

```
while true # Waits for a event and then log, then waits again ...recursively
do 
inotifywait -r -e modify,attrib,close_write,move,create,delete /home/lionel/Documents |logger -p kern.crit
done
```
Note: You can specify the `FACILITY` and the `LEVEL` to log. CHeck out the man of `logger` program

#Other alternatives

There is also the `node-inotify` built as a module for notify with `Node.js`
