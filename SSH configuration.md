
# Configure secure shell server (OpenSSH)
SSH service must have a secure configuration to allow and do what is required.
Other good source :http://knowledgepia.com/en/k-blog/linux-security/how-to-harden-ssh-with-identities-and-certificates
##### Authentication
The secure shell server must implement two-factor authentication that is both authentication via password and via public-key.

A authentication without public-key must be refused.
##### Ssh configuration file
Make sure these following variables are set in the  `/etc/ssh/sshd_config` or `/etc/ssh/ssh_config ` configuration file :

```
# CHANGE DEFAULT PORT
Port 7200

#ONLY USE PROTOCOL 2
Protocol 2

#ALLOW ONLY SPECIFIC USERS OR GROUPS (THAT WE WILL PROVIDE)
AllowUsers Inno_user1 Inno_user2 Inno_user3
AllowGroups sysadmin developers ...

#DISCONNECT SSH WHEN NO ACTIVITY,[TEST EACH 3 MINS IF THE CLIENT IS  ALIVE IF NOT TEST
#AGAIN 2 TIMES THEN CLOSE THE SESSION]
ClientAliveInterval 180
ClientAliveCountMax 3

#MUST SPECIFY HOW MANY SECONDS TO KEEP THE CONNECTION ALIVE WITHOUT SUCCESSFULLY LOGGING IN. (30 SECONDS)
LoginGraceTime 30

# DISABLE ROOT LOGIN ONLY SUDO
PermitRootLogin no

# REFUSE A LOGIN ATTEMPT IF THE AUTHENTICATION FILES ARE READABLE BY EVERYONE.
StrictModes yes

PasswordAuthentication yes
PermitEmptyPasswords no
PublicKeyAuthentication yes
HostbasedAuthentication no

# Banner: YOU ARE ACCESSING A EntrepriseX INFORMATION SYSTEM,..., YOU ARE RESPONSIBLE ...
Banner /etc/EntrepriseX_banner
```
