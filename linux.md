#Some tips in Linux 
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

