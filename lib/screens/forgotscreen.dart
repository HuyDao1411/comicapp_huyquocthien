import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../user_auth/widgets/form_container_widget.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController _emailController= TextEditingController();
  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }
  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text('Check your email!'),
            );
          }
      );

    }on FirebaseAuthException catch(e){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('Reset password',style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter your email'),
          SizedBox(
            height: 30,
          ),
          FormContainerWidget(
            controller: _emailController,
            hintText: "Email"
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
              onPressed: passwordReset,
            child: Text('Reset Password', style: TextStyle(color: Colors.white),),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
