
#Configure the email notifier SSMTP

`SSMTP` is our choice because it is more lightweight than  POSTFIX.

Download and install the Mail Transfer Agent ssmtp.
```python
apt-get install ssmtp
```
Edit the file `/etc/ssmtp/ssmtp.conf` so it looks like this:
```ngnix
root=email_notifier@gmail.com
mailhub=smtp.gmail.com:587
rewriteDomain=gmail.com
hostname=Machine_Name
AuthUser=email_sender
AuthPass=email_sender_password
FromLineOverride=YES
#UseTLS=yes                   # apparently has been deprecated
UseSTARTTLS=YES

#For further details (man ssmtp && man ssmtp.conf)
```
The value of `enterprise_notifier` will be given to you.

*Note*: At gmail the `email_sender` must be an account that is configured as `less secure` 
if not email notifications will not be sent from the server.
### How to send an email notification
Here is an example of how to send an notification to our email 
(#Notice that there is no space between \n and the begining of the body)
```python
echo -e "Subject: Report Alert \nHere it is the body of the message " | ssmtp enterprise_report@gmail.com
```
