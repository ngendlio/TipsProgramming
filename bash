#Example of how to use bash scripting in linux
```
#!/bin/bash
username=$USER;
machine=$HOSTNAME;

echo 'Script de: ' $username 'sur la machine: ' $machine;

echo '1st arg = '$1;
echo '2nd arg = '$2;
echo 'My script ='$0;
echo ' You gave '$# ' arguments';
echo 'And thoz args are '$@;
read -p 'Donnez votree age pour continuer:' age;
if [ $# -gt 1 ]
 then 
        echo you gave too many args
        exit;
fi
if [ $1 -gt 10  ]
 then
        echo Hey you are really old BRO.
        if (( $1 % 2 == 0 ))
         then
          echo Ton age est pair;.
        else
          echo Ton age est impair, hahah
        fi
fi
echo ' L\'age donne est' $age
echo ' ================Script  lasted ' $SECONDS;

```
