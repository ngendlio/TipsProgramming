# Some tips in Linux 
## Permissions
### Change Owner file
```
chown user1 user1 filename
```
## Change group of a file
```
chgrp groupName filename
```
## Change permissions on file
```
chmod 700 filename
```
`Sticky Bit `:1, `GUID`:2, `SUID`:4.

Example
```
chmod 4600 filename
```
##Find files that have specific permissions
Here we will find files and folders with 6000 permissions... for the user `user1`
```
sudo find / -type f  -user user1  -perm /6000 -exec ls -l {} \;
```
## Users
### Add a new user
```
sudo	adduser	sandra
```
### Create user with specific information
```
sudo adduser xxxxxx  -M -c ' XXXXX est un software dev du site' -g 'developers'
```
Then create His password
```
sudo passwd	sandra
```
### Delete a user
```
sudo	deluser	--remove-all-files	--remove-home	andrew
```

## Shutdown the system with a message 
```
sudo	shutdown	-h	18:30	"System	is	going	down	for	maintenance	this
evening	at	6:30	p.m.	Please	make	sure	you	have	saved	your	work	and	logged	out	by
then	or	you	may	lose	data."
```
## Examples 
Create a group `+` change the group	ownership `+` Add a user to a group `+` Make a user	X	the	group	administrator	with	the	gpasswd command so that He can add others users.
```
# Create a group 
sudo	groupadd	groupeX

# Change the owner group of the target folder
sudo	chgrp	groupeX /home/lionel/FolderX

# Add user lionel to the groupeX
sudo	usermod	-G	groupeX lionel

# Make lionel the administrator of the group groupeX
sudo	gpasswd	-A	lionel
```





