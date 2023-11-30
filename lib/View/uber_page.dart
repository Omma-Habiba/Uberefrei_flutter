import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_view.dart';

class UberPage extends StatefulWidget {
  @override
  _UberPageState createState() => _UberPageState();
}

class _UberPageState extends State<UberPage> {
  Stream<QuerySnapshot>? _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = FirebaseFirestore.instance.collection('ubers').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uber'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          // Display the data from Firestore
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index)
          {
            DocumentSnapshot uber = snapshot.data!.docs[index];
            String uid = uber['uid'];
            String nom = uber['nom'] ?? 'Nom inconnu';
            String photoUrl = uber['photo'] ?? '';
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(photoUrl),
                  ),
                  title: Text(nom),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatView(uberId: uid, uberName: nom, isUber: false,),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          );
        },
      ),
    );
  }
}
