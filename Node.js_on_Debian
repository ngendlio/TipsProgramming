
###Source
https://ariejan.net/2011/10/24/installing-node-js-and-npm-on-ubuntu-debian/
#Installing Node.js and NPM on Ubuntu/Debian

This is just short snippet on how to install Node.js (any version) and NPM (Node Package Manager) on your Ubuntu/Debian system.
##Step 1 - Update your system

sudo apt-get update
sudo apt-get install git-core curl build-essential openssl libssl-dev

##Step 2 - Install Node.js

First, clone the Node.js repository:
```
git clone https://github.com/joyent/node.git
cd node
```
Now, if you require a specific version of Node:
```
git tag # Gives you a list of released versions
git checkout v0.4.12
```
Then compile and install Node like this:
```
./configure
make
sudo make install
```
Then, check if node was installed correctly:
```
node -v
```
##Step 3 - Install NPM

Simply run the NPM install script:
```
curl https://npmjs.org/install.sh | sudo sh
```
And then check it works:

npm -v

That’s all.
