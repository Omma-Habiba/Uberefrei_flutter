//gere toutes les opérations concernant la bdd Firebase
import 'dart:typed_data';
import 'package:eferei2023gr109/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FiresbaseService {
  //atttributs
  String? userID;
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference conversations = FirebaseFirestore.instance.collection('conversations');
  FiresbaseService({this.userID});

  //inscription un utilisateur
  Future<Future<MyUser?>> register(mail, mdp, nom, prenom) async {
    UserCredential credential =
        await auth.createUserWithEmailAndPassword(email: mail, password: mdp);
    String uid = credential.user!.uid;

    //debugPrint("I'm here!");
    Map<String, dynamic> map = {
      "mail": mail,
      "nom": nom,
      "prenom": prenom
    };
    adddUser(uid, map);
    return getUser(uid);
  }

  //récupérer notre model
  Future<MyUser?> getUser(String uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs[0].data() as Map<String, dynamic>;
        return MyUser(userData);
      } else {
        return null; // Aucun utilisateur correspondant à cet UID
      }
    } catch (e) {
      print("Erreur lors de la récupération de l'utilisateur : $e");
      return null;
    }
  }

  //Get the user data from firestore by id
  Future<MyUser>? userFromFirestore(uid) {
    return users?.doc(uid).get().then((value) {
      return MyUser({
        'uid': value.get("uid") ?? "",
        'nom': value.get("nom") ?? "",
        'prenom': value.get("prenom") ?? "",
        'mail': value.get("mail") ?? "",
        'photo': value.get("photo") ?? "",
        'gps': value.get("gps") ?? "",
        'messages': value.get("messages") ?? ""
      });
    });
  }

  Future<Stream<List<MyUser>>> get usersList async {
    Query queryUsers = users.orderBy('uid', descending: true);
      int length = await queryUsers.get().then((querySnapshot) {
        return querySnapshot.docs.length;
      });

      if (length == 0) {
        print("La collection est vide.");
      } else {
        print("La collection contient des éléments.");
      }
    return queryUsers.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MyUser({
          'uid': doc.get("uid") ?? "",
          'nom': doc.get("nom") ?? "",
          'prenom': doc.get("prenom") ?? "",
          'mail': doc.get("mail") ?? "",
          'photo': doc.get("photo") ?? "",
          'gps': doc.get("gps") ?? "",
          //'messages': doc.get("messages") ?? ""
        });
      }).toList();
    });
  }

  //connexion d'un utilisateur
  Future<Future<MyUser?>> connect(mail, mdp) async {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: mail, password: mdp);
    String uid = credential.user!.uid;
    return getUser(uid);
  }

  //ajouter un utilisateur
  adddUser(String uid, Map<String, dynamic> data) {
    users.doc(uid).set(data);
  }

  updateUser(String uid, Map<String, dynamic> data) {
    users.doc(uid).update(data);
  }

  Future<String> storageFile(
      {required String dossier,
      required String uid,
      required String nameFile,
      required Uint8List dataFile}) async {
    TaskSnapshot snapshot =
        await storage.ref("$dossier/$uid/$nameFile").putData(dataFile);
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
