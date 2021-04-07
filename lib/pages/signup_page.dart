import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsproject_finalmobile/Component/drawerslider.dart';
import 'package:newsproject_finalmobile/pages/insert_news_page.dart';
import 'package:newsproject_finalmobile/pages/loginwithphone.dart';
import 'login_page.dart';
import 'package:newsproject_finalmobile/repos/login_page_repo.dart' as loginRepo;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody,
    );
  }
  get _buildBody{
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 450,
        height: 800,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: 300,
            //   width: 300,
            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: Image.asset("assets/images/logo1.jpg"),
            // ),
            Container(
              height: 200,
              width: 200,
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
            SizedBox(height: 70,),
            _buildEmail,
            _buildPassword,
            _buildSignUp,
            Row(
              children: [
                _buildLoginWithPhonePage,

                _buildOpenSignInPage,
              ],
            )


          ],
        ),
      ),
    );
  }
  get _buildEmail{
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 400,
      height: 50,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
          hintText: "Enter Email",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),),
        ),
        controller: _emailCtrl,
      ),
    );
  }

  bool _hidden = true;

  get _buildPassword{
    return Container(
      margin: EdgeInsets.all(10),
      width: 400,
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
          hintText: "Enter Password",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),),
          suffixIcon: InkWell(child: Icon(_hidden ? Icons.visibility : Icons.visibility_off), onTap: (){
            setState(() {
              _hidden = !_hidden;
            });
          },),
        ),
        controller: _passCtrl,
        obscureText: _hidden,
      ),
    );
  }
  _showSnackBar(String text){
    var snackBar = SnackBar(content: Text(text),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  get _buildSignUp{
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.black),
      ),
      textColor: Colors.white,
      color: Colors.brown[500],
      child: Text("Sign up"),
      onPressed: (){
        loginRepo.signUp(_emailCtrl.text, _passCtrl.text).then((user) {
          if(user == null){
            _showSnackBar("Login Failed");
          }
          else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyApp2()));
          }
        }).catchError((error) => _showSnackBar("${error.toString()}"));
      },
    );
  }
  get _buildOpenSignInPage{
    return MaterialButton(
      child: Text("Already have account? Sign up"),
      onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
  }
  get _buildLoginWithPhonePage{
    return MaterialButton(
      child: Text("Login phone"),
      onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginWithPhonePage()));
      },
    );
  }

}
