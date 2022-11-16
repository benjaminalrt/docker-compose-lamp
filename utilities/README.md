# FICHIERS IMPORTANT

## new_site.sh - à placer dans /etc/apache2

Script permettant de créer des conf à la volée.
Depuis le container, ne pas oublier la première fois de le rendre exécutable au niveau des droits :
```
chmod +x docker.sh
```
Exécuter le script :
```
sudo ./new_site.sh $domaine_local $chemin_public_webroot
```

!!! Nécéssite le template.conf et le template-ssl.conf

## template.conf et template-ssl.conf

À placer dans /etc/apache2/sites-available du container

## docker.sh

Script permettant de se connecter dans le dossier de son choix avec l'user de son choix dans le container docker.

Depuis WSL, ne pas oublier la première fois de le rendre exécutable au niveau des droits 
```
chmod +x docker.sh
```

Exécuter le script pour se connecter :
```
./docker.sh
```

# ACTIONS À FAIRE

## Installer sudo : 
```
apt-get install sudo
```

## Créer un utilisateur
Pour des soucis de droit, il faut le même nom que sur WSL

```
sudo adduser $identifiant
```

## Ajouter l'utiisateur aux sudoers
Afin que les commandes sudo soient disponibles pour l'utilisateur
```
sudo usermod -aG sudo $identifiant
```

## Ajouter l'utilisateur au www-data group
Pour qu'il soit en mesure de faire du web
```
sudo adduser $identifiant www-data
```

## Modifier les droits du dossier web
Enfin, s'ajouter dans les droits web pour pouvoir coder depuis son IDE
```
sudo chown $identifiant:www-data /var/www -R
```


## 

alias dockergo='source ~/finddocker && launchdocker'