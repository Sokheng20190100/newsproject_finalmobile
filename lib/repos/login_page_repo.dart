import 'package:firebase_auth/firebase_auth.dart' as auth;

Future<auth.User> signIn(String email, String passsword) async{
  auth.UserCredential  credential = await auth.FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: passsword);
  if(credential == null){
    throw Exception("Login Failed");
  }
  else{
    return credential.user;
  }
}

Future<auth.User> signUp(String email, String passsword) async{
  auth.UserCredential  credential = await auth.FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: passsword);
  if(credential == null){
    throw Exception("Sign up Failed");
  }
  else{
    return credential.user;
  }
}

Future signOut() async{
  auth.FirebaseAuth.instance.signOut();
}