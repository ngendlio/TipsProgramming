
Cette installation ci est testee sur des OS Ubuntu et derivatives..
// Installer les packages 

sudo apt-get install texlive texlive-binaries texlive-fonts-recommended texlive-generic-recommended texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-pictures texlive-lang-french 
// Installer le compilateur en GUI 
sudo apt-get install texmaker

//  Installer le correcteur d 'orthographe dans Texmaker Latex Linux
sudo apt-get install hunspell hunspell-fr
Puis tu vas les trouver ici 
/usr/share/hunspell/fr_FR.dic 
Il faut faire un chmod +x -R /usr/share/hunspell/ pour les rendre accessibles
Puis dans latex tu fais:
Tu specifie le chemin dans configurer Latex->Editeur->
