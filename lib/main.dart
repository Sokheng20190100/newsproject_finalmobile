import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsproject_finalmobile/pages/startup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text("${snapshot.error}")));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StartupPage();
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}