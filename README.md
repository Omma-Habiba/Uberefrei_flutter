<h1 align="center">
  UberEfrei Flutter APP 🦄
</h1>

UberEfrei est une application de communication entre le client ('users' dans firebase) et les chauffeurs Uber ('ubers' dans firebase). 
Le client peut également accéder au google map et choisir un point de destination (parmis les points rouges affichés sur le map), puis accéder au paiement et peut être rediriger vers la page de messagerie avec son uber.

## Membres du groupe
- Omma Habiba BIPLOB
- Faiza AKABLI
- Ines BOUHRAOUA

## Fonctionnalités 🦊

### Home page avec deux choix : Client && Uber 

![image](https://github.com/Omma-Habiba/Uberefrei_flutter/assets/76633646/df839446-13d7-4348-9cb2-625915eed90d)


### Connecté en tant que Client Ochaco

![image](https://github.com/Omma-Habiba/Uberefrei_flutter/assets/76633646/72f900c7-26c9-44aa-b7b8-dbadb51a1449)

- **Personnes** : Affichage des ubers avec qui le client peut communiquer
![image](https://github.com/Omma-Habiba/Uberefrei_flutter/assets/76633646/f9e73dc8-aab4-4af8-9276-1e3c9c64bf2e)

- **Google map && Paiement** : Le client peut choisir un point de repère (points rouges) sur le map, une fois cliquer sur un des points rouges, ça affiche le pop-up du paiement. Une fois le paiement est valide, le client sera redirigé vers la page de conversation avec un uber en fonction du point de destination. Les points rouges ont été mit en dure dans une vue map.dart, chaque point est prédéfini d'un nom d'uber d'où on trouvera le nom de cet uber dans la conversation en tant que 'title' dans la collection 'conversations' dans firebase.
![image](https://github.com/Omma-Habiba/Uberefrei_flutter/assets/76633646/3c8286f2-691f-4a67-8cb9-e713c2f895a1)

  
### Connecté en tant que Uber
- Quand on est connecté en tant que Uber, on est redirigé directement vers la conversation avec le client qui a payé la réservation sur google map.
![image](https://github.com/Omma-Habiba/Uberefrei_flutter/assets/76633646/ad6a1fc7-34a8-414f-bc34-c61cd452b206)

### Conversation 
- La conversation se fait entre le client et le uber et ça s'enregistre dans la bases de données firebase dans la collection 'conversations'. Pour tester ça, il faut être connecter sur deux téléphones, un en tant que client, l'autre en tant que uber.
- **Particularité** : Lorsqu'un client ou un uber reçoit un message, il est obligé de partir de la conversation puis revenir dans la conversation afin de voir le nouveau message.

## Technologie utilisée
- **Flutter 3.16.0** : Framework de développement d'applications mobiles multiplateformes.
- **Dart 3.2.0** 
- **Firebase** : Plateforme de développement d'applications mobiles et web.

## Instructions d'utilisation
1. Cloner le repository du projet.
2. Installer Flutter sur votre machine si ce n'est pas déjà fait.
3. Installer les dépendances en exécutant `flutter pub get`.
4. Lancer l'application en utilisant `flutter run`.
