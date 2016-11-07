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
