# Inotify on Linux Systems
The inotify API provides a mechanism for monitoring filesystem
       events.  Inotify can be used to monitor individual files, or to
       monitor directories.  When a directory is monitored, inotify will
       return events for the directory itself, and for files inside the
       directory.

`Source`: http://man7.org/linux/man-pages/man7/inotify.7.html

`IBM on inotify`: http://www.ibm.com/developerworks/library/l-inotify/
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
## Watch and log and E-mail activities [Perfect Bash]
```
#!/bin/sh
MONITORDIR="/home/lionel/Documents"
EVENTS_TOWATCH="move,unmount,create,modify,delete"
MACHINE="$HOSTNAME"

inotifywait -m -r -e $EVENTS_TOWATCH --format '%w%f %e' "${MONITORDIR}" |
while read name event
  do
        case $event in 
           *"CREATE"* )
                MESSAGE=" vient d'être créee";;
           *"MOVE"*)
                MESSAGE=" vient d'être renommé ou deplacé";;
           *"UNMOUNT"*) 
                MESSAGE=" vient d'être demonté";;
           *"MODIFY"*)
                MESSAGE=" vient d'être modifié" ;;
           *"DELETE"*)
                MESSAGE=" vient d'être supprimé";;
           *)
                MESSAGE=" vient de subir une modification de type $event";;
        esac
        echo -e "Subject: Report Alert of ${MACHINE} \n\nDate: `date`, $name  ${MESSAGE} " | ssmtp ngendlio@gmail.com
        echo -e "Machine: ${MACHINE}, le `date`,\n $name ${MESSAGE} " 
  done

```
Note: You can specify the `FACILITY` and the `LEVEL` to log. CHeck out the man of `logger` program

#Other alternatives

There is also the `node-inotify` built as a module for notify with `Node.js`
