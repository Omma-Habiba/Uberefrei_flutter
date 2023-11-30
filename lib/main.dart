import 'package:eferei2023gr109/View/home_page.dart';
import 'package:eferei2023gr109/controller/my_permission_photo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MyPermissionPhoto().init();
  Stripe.publishableKey = "pk_test_51GQ8hTDVXOXIy9UxpbYscBnuiq9FTW63gCk5agdRp2JOjym1NvC03WVaEBdj6wwFkJzAeCit9ZA77sBTeQHaI9rI00fsdMSCog";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}