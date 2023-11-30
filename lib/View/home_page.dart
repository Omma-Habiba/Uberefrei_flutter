import 'package:eferei2023gr109/View/chat_view.dart';
import 'package:eferei2023gr109/View/dashboard.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SquareWidget(
              label: 'Client',
              color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyDashBoard()),
                  );
                  },
            ),
            SquareWidget(
              label: 'Uber',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatView(uberId: "ub_2", uberName: "Anya", isUber: true,)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SquareWidget extends StatelessWidget {
  final String label;
  final Color color;
  final Function()? onTap;

  const SquareWidget({
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}