import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? uid, nom, prenom, mail, photo;
  GeoPoint? gps;

  MyUser(Map<String, dynamic> map, {required }) {
    uid = map['uid'] ?? "";
    nom = map['nom'] ?? "";
    prenom = map['prenom'] ?? "";
    mail = map['mail'] ?? "";
    photo = map['photo'];
    gps = map['gps'];
  }

  Map<String, dynamic> getdata() {
    return {
      'uid': uid ?? "",
      'nom': nom ?? "",
      'prenom': prenom ?? "",
      'mail': mail ?? "",
      'photo': photo,
      'gps': gps,
    };
  }

  void setusername(nom, prenom) {
    nom = nom;
    prenom = prenom;
  }

  void setuid(uid) {
    this.uid = uid;
  }

  //constructeur
  MyUser.empty(){
    uid = "";
    nom ="";
    prenom = "";
    mail ="";
    photo = "";
    //gps = "";
  }

}