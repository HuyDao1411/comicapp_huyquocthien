import 'package:comicappver2/screens/sign_up_screen.dart';
import 'package:comicappver2/user_auth/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'forgotscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignIn=false;
  final FirebaseAuthService _auth = FirebaseAuthService();


  TextEditingController _emailController= TextEditingController();
  TextEditingController _passwordController= TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF44A3E),
        title: Center(child: Text('Login')),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot password ?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ForgotScreen()));
                    },
                    child: Text("Forgot",style: TextStyle(color: Colors.blue, fontWeight:FontWeight.bold),),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap:_signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFF44A3E),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: _isSignIn?CircularProgressIndicator(color: Colors.white,):Text('Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>SignUpScreen()), (route) => false);
                    },
                    child: Text("Sign Up",style: TextStyle(color: Colors.blue, fontWeight:FontWeight.bold),),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  void _signIn() async{
    setState(() {
      _isSignIn = true;
    });

    String email=_emailController.text;
    String password=_passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSignIn=false;
    });

    if (user != null) {
      print("User is sucessfully SignIn");
      Navigator.pushNamedAndRemoveUntil(context, '/myhome',(route) => false);
    }
    else{
      print("Some error happend");
    }
  }
}
