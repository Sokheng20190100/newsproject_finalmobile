import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:newsproject_finalmobile/Component/drawerslider.dart';
import 'package:newsproject_finalmobile/pages/insert_news_page.dart';
import 'package:newsproject_finalmobile/pages/login_page.dart';
import 'package:newsproject_finalmobile/pages/signup_page.dart';


class LoginWithPhonePage extends StatefulWidget {
  @override
  _LoginWithPhonePageState createState() => _LoginWithPhonePageState();
}

class _LoginWithPhonePageState extends State<LoginWithPhonePage> {
  final _logo =
      "https://i.pinimg.com/originals/03/cf/d4/03cfd4c3f64873186972df27ad569f22.png";

  double _widthOfScreen;

  var _codeCtrl = TextEditingController(text: "855");
  var _phoneCtrl = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: InkWell(
        child: _buildBody,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }

  get _buildBody {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLogo,
            _buildLoginPanel,

          ],
        ),
      ),
    );
  }
  get _buildOpenSignupPage{
    return MaterialButton(
      child: Text("haven't acc sign up"),
      onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
      },
    );
  }
  get _buildOpenSignInPage{
    return MaterialButton(
      child: Text("Sign up"),
      onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
  }
  get _buildLogo {
    return Container(
      height: 300,
      width: 300,
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
    );
  }

  get _buildLoginPanel {
    return Container(
      height: 500,
      child: Column(
        children: [
          _buildPhoneTextPanel,
          _buildLoginButton,
          Row(
            children: [
              SizedBox(width: 60),
              _buildOpenSignupPage,
              _buildOpenSignInPage,
            ],
          ),
        ],
      ),
    );
  }

  get _buildPhoneTextPanel {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          _buildCodeTextField,
          SizedBox(width: 10),
          Expanded(child: _buildPhoneTextField),
        ],
      ),
    );
  }

  get _buildCodeTextField {
    return Container(
      width: 80,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: _codeCtrl,
        decoration: InputDecoration(
          hintText: "Code",
          prefixText: "+",
        ),
      ),
    );
  }

  get _buildPhoneTextField {
    return Container(
      child: TextField(
        keyboardType: TextInputType.number,
        controller: _phoneCtrl,
        decoration: InputDecoration(
          hintText: "Enter phone number",
        ),
      ),
    );
  }

  get _buildLoginButton {
    return Container(
      width: 350,
      height: 40,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.brown[500]),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          String number = "+${_codeCtrl.text.trim()}${_phoneCtrl.text.trim()}";
          print("class Niptict2PhonePage, number: $number");
          _verifyPhone(number);
        },
        icon: Icon(Icons.logout),
        label: Text("Login"),
      ),
    );
  }

  String _verifiedId = "";

  _verifyPhone(String number) {
    var verificationCompleted = (auth.PhoneAuthCredential credential) async {
      final userCredential =
      await auth.FirebaseAuth.instance.signInWithCredential(credential);
      _onCompleted(userCredential.user);
    };

    var verificationFailed = (auth.FirebaseAuthException ex) {
      print("Error ${ex.message}");
      _showSnackBar("Error ${ex.message}");
    };

    var codeSent = (String verId, [int forceResendingCode]) async {
      _verifiedId = verId;

      auth.User user = await showDialog(
          context: context, builder: (context) => _alertDialog);
      _onCompleted(user);
    };

    var codeAutoRetrievalTimeout = (String verId) {
      _verifiedId = verId;
      _showSnackBar("Error time out");
    };

    auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  _onCompleted(auth.User user) {
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyApp2(),
        ),
      );
    } else {
      _showSnackBar("Something went wrong while verifying phone number.");
    }
  }

  var _smsCode = TextEditingController();

  get _alertDialog {
    return AlertDialog(
      title: Text("Enter PIN"),
      content: TextField(
        keyboardType: TextInputType.number,
        controller: _smsCode,
        decoration: InputDecoration(
          hintText: "Enter PIN",
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              auth.AuthCredential credential =
              auth.PhoneAuthProvider.credential(
                verificationId: _verifiedId,
                smsCode: _smsCode.text.trim(),
              );

              auth.UserCredential userCredential = await auth
                  .FirebaseAuth.instance
                  .signInWithCredential(credential);

              Navigator.of(context).pop(userCredential.user);
            },
            child: Text("Verify")),
      ],
    );
  }
}
