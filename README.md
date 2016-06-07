#Wordpress + Composer + Git

##1) - Installation via Composer
1. Renommer le fichier `dev-config.sample.php` en `dev-config.php` ou `production-config.php`
2. Créez une nouvelle base de donnée sur le serveur (en local ou distant)
3. Modifier le fichier avec vos identifiants de bdd (user, pass, host, bdd name)
4. Lancer la commande `composer install`
5. Wordpress se télécharge dans `/public/wp`
6. Le code custom se trouve dans `/public/wp-content`

##2) - Import de la BDD
1. Lancer le script dploy.sh
	1. Impot du dump de la bdd
	2. Modification des URL