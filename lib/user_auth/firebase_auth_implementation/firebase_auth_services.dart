

import 'package:comicappver2/user_auth/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e){
      print("Some error occured");

    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e){
      showToast(message: 'Invalid email or password');
    }
    return null;
  }


}