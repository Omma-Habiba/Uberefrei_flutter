import 'dart:typed_data';
import 'package:eferei2023gr109/View/uber_page.dart';
import 'package:eferei2023gr109/View/my_background.dart';
import 'package:eferei2023gr109/constant.dart';
import 'package:eferei2023gr109/service/user_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'map.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({super.key});

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  bool changedPrenom = false;
  TextEditingController prenom = TextEditingController();
  String? nameImage;
  Uint8List? byteImage;
  int currentIndexTapped = 0;

  popImage() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Souhaitez vous enregistrer cette image ?"),
            content: Image.memory(byteImage!),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("NON")),
              TextButton(
                  onPressed: () {
                    //plusieurs opérations
                    FiresbaseService()
                        .storageFile(
                            dossier: "IMAGES",
                            uid: moi.uid ?? "1",
                            nameFile: nameImage!,
                            dataFile: byteImage!)
                        .then((value) {
                      setState(() {
                        moi.photo = value;
                      });
                      Map<String, dynamic> data = {"PHOTO": moi.photo};
                      FiresbaseService().updateUser(moi.uid ?? "", data);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("OUI"))
            ],
          );
        });
  }

  pickImage() async {
    FilePickerResult? resultat = await FilePicker.platform
        .pickFiles(withData: true, type: FileType.image);
    if (resultat != null) {
      nameImage = resultat.files.first.name;
      byteImage = resultat.files.first.bytes;
      popImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexTapped,
        onTap: (value) {
          setState(() {
            currentIndexTapped = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Personnes"),
          //BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Cartes"),
        ],
      ),
      drawer: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.66,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(80),
                  topRight: Radius.circular(80))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(imageDefault),
                ),
              ),

              (changedPrenom)
                  ? TextField(
                      controller: prenom,
                      decoration: InputDecoration(hintText: "Entrer le prénom"),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          moi.prenom ?? "Ochaco",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                changedPrenom = true;
                              });
                            },
                            icon: const Icon(Icons.u_turn_right_sharp))
                      ],
                    ),
              (changedPrenom)
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          changedPrenom = false;
                          moi.prenom = prenom.text;
                        });
                        Map<String, dynamic> data = {"PRENOM": moi.prenom};
                        FiresbaseService().updateUser(moi.uid ?? "", data);
                      },
                      child: const Text("Enregistrement"))
                  : Container(),
              Text(
                moi.nom ?? "Uraraka",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          )),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const MyBackground(),
          bodyPage(),
        ],
      ),
    );
  }

  Widget bodyPage() {
    switch (currentIndexTapped) {
      case 0:
        return UberPage();
      case 1  :
        return GPSMapPage(title: 'GPS',);
      default:
        return const Text("Impossible");
    }
  }
}
