Command line instructions


Git global setup

git config --global user.name "Lionel ngend"
git config --global user.email "ngendlio@gmail.com"

Create a new repository

git clone https://gitlab.com/ngendlio/ProjeTest.git
cd ProjeTest
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master

Existing folder

cd existing_folder
git init
git remote add origin https://gitlab.com/ngendlio/ProjeTest.git
git add .
git commit -m "Initial commit"
git push -u origin master

Existing Git repository

cd existing_repo
git remote add origin https://gitlab.com/ngendlio/ProjeTest.git
git push -u origin --all
git push -u origin --tags
