# Inotify on Linux Systems
The inotify API provides a mechanism for monitoring filesystem
       events.  Inotify can be used to monitor individual files, or to
       monitor directories.  When a directory is monitored, inotify will
       return events for the directory itself, and for files inside the
       directory.
`Source`: http://man7.org/linux/man-pages/man7/inotify.7.html
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

Just add  the logger program after an event, then the event will go directly to the syslog program,
## Watch and log activities [Perfect Bash]
```
#!/bin/sh
MONITORDIR="/home/lionel/Documents"
EVENTS="modify,attrib,close_write,move,create,delete"
inotifywait -m -r -e $EVENTS --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
  # Send by mail
        echo " ${NEWFILE} has been created"
  # Log to the journal
        echo "${NEWFILE} has been created"  | logger -p kern.crit
done
```
Note: You can specify the `FACILITY` and the `LEVEL` to log. CHeck out the man of `logger` program

#Other alternatives

There is also the `node-inotify` built as a module for notify with `Node.js`
