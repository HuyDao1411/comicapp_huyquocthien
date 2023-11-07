import 'package:comicappver2/screens/login_screen.dart';
import 'package:comicappver2/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:comicappver2/user_auth/toast.dart';
import 'package:comicappver2/user_auth/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isSignUp=false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController= TextEditingController();
  TextEditingController _emailController= TextEditingController();
  TextEditingController _passwordController= TextEditingController();
  TextEditingController _passwordcheckController=TextEditingController();

  @override
  void dispose(){
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordcheckController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF44A3E),
          title: Center(child: Text('SignUp')),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up",
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
                FormContainerWidget(
                  controller: _passwordcheckController,
                  hintText: "Password check",
                  isPasswordField: true,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Color(0xFFF44A3E),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: _isSignUp?CircularProgressIndicator(color: Colors.white,):Text('Sign Up',
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
                    Text("Already have an account?"),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>LoginScreen()), (route) => false);
                      },
                      child: Text("Login",style: TextStyle(color: Colors.blue, fontWeight:FontWeight.bold),),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  void _signUp() async{
    setState(() {
      _isSignUp=true;
    });

    String username=_usernameController.text;
    String email=_emailController.text;
    String password=_passwordController.text;
    String passwordcheck=_passwordcheckController.text;

    setState(() {
      _isSignUp=false;
    });

    if (password==passwordcheck){
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        showToast( message: 'User is sucessfully created');
        Navigator.pushNamedAndRemoveUntil(context, '/login',(route)=>false );
      }
      else{
        showToast( message: 'User already exists');
      }
    } else {
      showToast(message: "Incorrect password check");
    }

  }
}
