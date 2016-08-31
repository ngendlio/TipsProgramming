
#Configure an HIDS (Host based intrusion detection system)
An HIDS must be installed so that we controll any modification of some specific folders and files.

The HIDS must send us a **email notification** to our email address(that we will provide i.e innoveos_report) via ssmtp in case of a supervised folder or file is modified.

We recommend the file integrity checker `tripwire` because of it's detailled reports.

## Configure Tripwire HIDS
During the installation you will be asked to give 2 passwords (keys). Don't forget them.
##### Install tripwire
```
sudo apt-get install tripwire 
```
##### Generate the policy file for tripwire by doing
 ```
 sudo twadmin --create-polfile /etc/tripwire/twpol.txt
 ```
##### Initialize the database of tripwire to check if all the specified paths in ` /etc/tripwire/twpol.txt` exist on the
 system 
 ```
sudo tripwire --init
```

##### If there is some paths that are labeled as non-existant, comment them out in the policy file ` /etc/tripwire/twpol.txt`
```
sudo nano /etc/tripwire/twpol.txt
```

##### Change some severity options  by replacing all the ` severity = $(SIG_MED)` and ` severity = $(SIG_LOW)`
by  `severity = $(SIG_HI)` because we want to be notified of any change on our system.
##### Comment out some paths that changes too much. For example `/var/log/` by `#/var/log/`
The policy file should like that:

```
#
# Standard Debian Tripwire configuration
#
#
# This configuration covers the contents of all 'Essential: yes'
# packages along with any packages necessary for access to an internet
# or system availability, e.g. name services, mail services, PCMCIA
# support, RAID support, and backup/restore support.
#

#
# Global Variable Definitions
#
# These definitions override those in to configuration file.  Do not         
# change them unless you understand what you're doing.
#

@@section GLOBAL
TWBIN = /usr/sbin;
TWETC = /etc/tripwire;
TWVAR = /var/lib/tripwire;

#
# File System Definitions
#
@@section FS

#
# First, some variables to make configuration easier
#
SEC_CRIT      = $(IgnoreNone)-SHa ; # Critical files that cannot change

SEC_BIN       = $(ReadOnly) ;        # Binaries that should not change

SEC_CONFIG    = $(Dynamic) ;         # Config files that are changed
		        # infrequently but accessed
		        # often

SEC_LOG       = $(Growing) ;         # Files that grow, but that
			             # should never change ownership

SEC_INVARIANT = +tpug ;              # Directories that should never
		        # change permission or ownership

SIG_LOW       = 33 ;                 # Non-critical files that are of
				     # minimal security impact

SIG_MED       = 66 ;                 # Non-critical files that are of
				     # significant security impact

SIG_HI        = 100 ;                # Critical files that are
				     # significant points of
				     # vulnerability
# this is the email we should report to:
MAILTO = innoveos_report@gmail.com ;

#### ALL THE FILES ARE SET TO SIG_HI SO THAT ANY CHANGE BE REPORTED ###

#
# Tripwire Binaries
#
(
  rulename = "Tripwire Binaries",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	$(TWBIN)/siggen			-> $(SEC_BIN) ;
	$(TWBIN)/tripwire		-> $(SEC_BIN) ;
	$(TWBIN)/twadmin		-> $(SEC_BIN) ;
	$(TWBIN)/twprint		-> $(SEC_BIN) ;
}

#
# Tripwire Data Files - Configuration Files, Policy Files, Keys,
# Reports, Databases
#

# NOTE: We remove the inode attribute because when Tripwire creates a
# backup, it does so by renaming the old file and creating a new one
# (which will have a new inode number).  Inode is left turned on for
# keys, which shouldn't ever change.

# NOTE: The first integrity check triggers this rule and each
# integrity check afterward triggers this rule until a database update
# is run, since the database file does not exist before that point.
(
  rulename = "Tripwire Data Files",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	$(TWVAR)/$(HOSTNAME).twd	-> $(SEC_CONFIG) -i ;
	$(TWETC)/tw.pol			-> $(SEC_BIN) -i ;
	$(TWETC)/tw.cfg			-> $(SEC_BIN) -i ;
	$(TWETC)/$(HOSTNAME)-local.key	-> $(SEC_BIN) ;
	$(TWETC)/site.key		-> $(SEC_BIN) ;

	#don't scan the individual reports
	$(TWVAR)/report			-> $(SEC_CONFIG) (recurse=0) ;
}

#
# Critical System Boot Files
# These files are critical to a correct system boot.
#
(
  rulename = "Critical system boot files",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/boot			-> $(SEC_CRIT) ;
	/lib/modules		-> $(SEC_CRIT) ;
}

(
  rulename = "Boot Scripts",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/etc/init.d		-> $(SEC_BIN) ;
	#/etc/rc.boot		-> $(SEC_BIN) ;
	/etc/rcS.d		-> $(SEC_BIN) ;
	/etc/rc0.d		-> $(SEC_BIN) ;
	/etc/rc1.d		-> $(SEC_BIN) ;
	/etc/rc2.d		-> $(SEC_BIN) ;
	/etc/rc3.d		-> $(SEC_BIN) ;
	/etc/rc4.d		-> $(SEC_BIN) ;
	/etc/rc5.d		-> $(SEC_BIN) ;
	/etc/rc6.d		-> $(SEC_BIN) ;
}


#
# Critical executables
#
(
  rulename = "Root file-system executables",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/bin			-> $(SEC_BIN) ;
	/sbin			-> $(SEC_BIN) ;
}

#
# Critical Libraries
#
(
  rulename = "Root file-system libraries",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/lib			-> $(SEC_BIN) ;
}


#
# Login and Privilege Raising Programs
#
(
  rulename = "Security Control",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/etc/passwd		-> $(SEC_CONFIG) ;
	/etc/shadow		-> $(SEC_CONFIG) ;
}




#
# These files change every time the system boots
#
(
  rulename = "System boot changes",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/var/lock		-> $(SEC_CONFIG) ;
	/var/run		-> $(SEC_CONFIG) ; # daemon PIDs
	/var/log		-> $(SEC_CONFIG) ;
}

# These files change the behavior of the root account
(
  rulename = "Root config files",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/root                           -> $(SEC_CRIT) ; # Catch all additions to /root
    #/root/mail                     -> $(SEC_CONFIG) ;
    #/root/Mail                     -> $(SEC_CONFIG) ;
    #/root/.xsession-errors         -> $(SEC_CONFIG) ;
    #/root/.xauth                   -> $(SEC_CONFIG) ;
    #/root/.tcshrc                  -> $(SEC_CONFIG) ;
    #/root/.sawfish                 -> $(SEC_CONFIG) ;
    #/root/.pinerc                  -> $(SEC_CONFIG) ;
    #/root/.mc                      -> $(SEC_CONFIG) ;
    #/root/.gnome_private           -> $(SEC_CONFIG) ;
    #/root/.gnome-desktop           -> $(SEC_CONFIG) ;
    #/root/.gnome                   -> $(SEC_CONFIG) ;
    #/root/.esd_auth                        -> $(SEC_CONFIG) ;
    #/root/.elm                     -> $(SEC_CONFIG) ;
    #/root/.cshrc                   -> $(SEC_CONFIG) ;
    /root/.bashrc                   -> $(SEC_CONFIG) ;
    #/root/.bash_profile            -> $(SEC_CONFIG) ;
    #/root/.bash_logout             -> $(SEC_CONFIG) ;
    /root/.bash_history             -> $(SEC_CONFIG) ;
    #/root/.amandahosts             -> $(SEC_CONFIG) ;
    #/root/.addressbook.lu          -> $(SEC_CONFIG) ;
    #/root/.addressbook             -> $(SEC_CONFIG) ;
    #/root/.Xresources              -> $(SEC_CONFIG) ;
    #/root/.Xauthority              -> $(SEC_CONFIG) -i ; # Changes Inode number on login
    #/root/.ICEauthority                -> $(SEC_CONFIG) ;
}

#
# Critical devices
#
(
  rulename = "Devices & Kernel information",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
    /dev		-> $(Device) ;
    /dev/pts                -> $(Device) ;
    #/proc                  -> $(Device) ;
    /proc/devices           -> $(Device) ;
    /proc/net               -> $(Device) ;
    /proc/tty               -> $(Device) ;
    /proc/sys               -> $(Device) ;
    /proc/cpuinfo           -> $(Device) ;
    /proc/modules           -> $(Device) ;
    /proc/mounts            -> $(Device) ;
    /proc/dma               -> $(Device) ;
    /proc/filesystems       -> $(Device) ;
    /proc/interrupts        -> $(Device) ;
    /proc/ioports           -> $(Device) ;
    /proc/scsi              -> $(Device) ;
    /proc/kcore             -> $(Device) ;
    /proc/self              -> $(Device) ;
    /proc/kmsg              -> $(Device) ;
    /proc/stat              -> $(Device) ;
    /proc/loadavg           -> $(Device) ;
    /proc/uptime            -> $(Device) ;
    /proc/locks             -> $(Device) ;
    /proc/meminfo           -> $(Device) ;
    /proc/misc              -> $(Device) ;

}

#
# Other configuration files
#
(
  rulename = "Other configuration files",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/etc		-> $(SEC_BIN) ;
}

#
# Binaries
#
(
  rulename = "Other binaries",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/usr/local/sbin	-> $(SEC_BIN) ;
	/usr/local/bin	-> $(SEC_BIN) ;
	/usr/sbin	-> $(SEC_BIN) ;
	/usr/bin	-> $(SEC_BIN) ;
}

#
# Libraries
#
(
  rulename = "Other libraries",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{

	/usr/local/lib	-> $(SEC_BIN) ;
	/usr/lib	-> $(SEC_BIN) ;
}

#
# Commonly accessed directories that should remain static with regards
# to owner and group
#
(
  rulename = "Invariant Directories",
  severity = $(SIG_HI),
  emailto = $(MAILTO)
)
{
	/		-> $(SEC_INVARIANT) (recurse = 0) ;
	/home		-> $(SEC_INVARIANT) (recurse = 0) ;
	/tmp		-> $(SEC_INVARIANT) (recurse = 0) ;
	/usr		-> $(SEC_INVARIANT) (recurse = 0) ;
	/var		-> $(SEC_INVARIANT) (recurse = 0) ;
	/var/tmp	-> $(SEC_INVARIANT) (recurse = 0) ;
	#/var/lock              -> $(SEC_CONFIG) ;
	#/var/run               -> $(SEC_CONFIG) ; # daemon PIDs

}
```
##### Edit also the configuration policy of tripwire, `/etc/tripwire/twcfg.txt`
and it should look like this:

```
ROOT          =/usr/sbin
POLFILE       =/etc/tripwire/tw.pol
DBFILE        =/var/lib/tripwire/$(HOSTNAME).twd
REPORTFILE    =/var/lib/tripwire/report/$(HOSTNAME)-$(DATE).twr
SITEKEYFILE   =/etc/tripwire/site.key
LOCALKEYFILE  =/etc/tripwire/$(HOSTNAME)-local.key
EDITOR        =/usr/bin/editor
LATEPROMPTING =false
LOOSEDIRECTORYCHECKING =false
MAILNOVIOLATIONS =false
EMAILREPORTLEVEL =3
REPORTLEVEL   =3
SYSLOGREPORTING =true
MAILMETHOD    =SENDMAIL
MAILPROGRAM   =/usr/sbin/sendmail -oi -t
 #SMTPHOST      =localhost
 #SMTPPORT      =25
TEMPDIRECTORY =/tmp
```

##### Recompile the encrypted and configuration policy files to consider new settings
```
sudo twadmin --create-cfgfile -S /etc/tripwire/site.key /etc/tripwire/twcfg.txt
sudo twadmin -m P /etc/tripwire/twpol.txt
````
##### Reinitialize the database to implement our new policy:
```
sudo tripwire --init
```
##### Test if tripwire can send email
```
/usr/sbin/tripwire --test --email xxxxxx@xxxx.com
```
### Run a scan and see the report via email preconfigured
```
sudo tripwire --check -M
```
### Schedule tripwire to run hourly in this file `/etc/cron.hourly/tripwire` by editing it to:

```
#!/bin/sh -e

tripwire=/usr/sbin/tripwire
[ -x $tripwire ] || exit 0
umask 027
$tripwire --check --quiet --email-report

```
More about crontab :https://www.unixmen.com/add-cron-jobs-linux-unix/
# Define permissions 
```
#chmod 700 /root

#chmod 700 /var/log/audit

#chmod 740 /etc/rc.d/init.d/iptables

#chmod 740 /sbin/iptables

#chmod –R 700 /etc/skel

#chmod 600 /etc/rsyslog.conf

#chmod 640 /etc/security/access.conf

#chmod 600 /etc/sysctl.conf
```
