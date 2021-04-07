import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:newsproject_finalmobile/Component/drawerslider.dart';
import 'package:newsproject_finalmobile/pages/login_page.dart';
import 'package:newsproject_finalmobile/pages/loginwithphone.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class DeletePage extends StatefulWidget {
  @override
  _DeletePageState createState() => _DeletePageState();
}

// var scaffolKey = GlobalKey<ScaffoldState>();

class _DeletePageState extends State<DeletePage> {
  // final _logo =
  //     "https://i.pinimg.com/originals/03/cf/d4/03cfd4c3f64873186972df27ad569f22.png";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), (){
      auth.FirebaseAuth.instance.authStateChanges().listen((event) {
        if(mounted){
          if (event != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MyApp2(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 320,
          width: 320,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/logo1.jpg"),
                fit: BoxFit.cover,
              )
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}





