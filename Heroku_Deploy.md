#Intro
GO to https://dashboard.heroku.com/new?org=personal-apps
and create a new APP then call it as youlike. But for me i called it : ngendlio-app1

So,....

##Install the Heroku CLI

##Download and install the Heroku CLI.

If you haven't already, log in to your Heroku account and follow the prompts to create a new SSH public key.

```$ heroku login```
##Create a new Git repository

Initialize a git repository in a new or existing directory
```
$ cd my-project/
$ git init
$ heroku git:remote -a ngendlio-app1
```
Deploy your application

Commit your code to the repository and deploy it to Heroku using Git.
```
$ git add .
$ git commit -am "make it better"
$ git push heroku master
```
###Existing Git repository

For existing repositories, simply add the heroku remote
```
$ heroku git:remote -a ngendlio-app1
```
