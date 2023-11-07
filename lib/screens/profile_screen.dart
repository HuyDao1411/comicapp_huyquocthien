import 'package:comicappver2/component/text_box.dart';
import 'package:comicappver2/user_auth/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser=FirebaseAuth.instance.currentUser;

  Future<void> editFieldpassword(String field) async {
    String newValue='';
    await showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Change ${field}', style: TextStyle(color: Colors.white),),
          content: TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter new ${field}',
              hintStyle: TextStyle(color: Colors.grey)
            ),
            onChanged: (value){
              newValue=value;
            },
          ),
          actions: [
            TextButton(
              onPressed: ()=>Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: (){
                currentUser?.updatePassword(newValue);
                Navigator.of(context).pop(newValue);
                showToast(message: 'Done');
              },
              child: Text('Save', style: TextStyle(color: Colors.white)),
            )
          ],
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
        backgroundColor: const Color(0xFFF44A3E),
          title: Center(
              child: Center(
               child: Text("Profile")
           ),
          )
        ),
      body: ListView(
        children: [
          SizedBox(height: 50,),
          Icon(Icons.person,
          size:72 ,
          ),
          SizedBox(height: 7,),
          Text(currentUser!.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey
            ),
          ),
          SizedBox(height: 50,),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text('My Details',
            style: TextStyle(color: Colors.grey),
            ),
          ),
          MyTextBox(
            text: "${currentUser?.email?.split('@')[0]}",
            sectionName: 'username',
            onPressed: (){
              showToast(message: 'Can\'t update user name');
            },
          ),
          MyTextBox(
            text: "***",
            sectionName: 'password',
            onPressed: ()=> editFieldpassword('password'),
          ),
          SizedBox(height: 50,),




        ],
      ),
    );

    }
}