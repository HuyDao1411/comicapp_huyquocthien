import 'package:comicappver2/component/myListTitle.dart';
import 'package:comicappver2/state/agrument.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/comic.dart';

class MyDrawer extends StatelessWidget {
  late List<Comic> comics;
  MyDrawer(this.comics);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: Column(
        children: [
          DrawerHeader(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              ),
          ),
          MyListTitle(
              icon: Icons.home,
              text: "H O M E",
            onTap: () => Navigator.pop(context),
          ),
          MyListTitle(
              icon: Icons.account_circle_outlined,
              text: "P R O F I L E",
            onTap: (){
                Navigator.pushNamed(context, '/profile');
            },
          ),
          MyListTitle(
              icon: Icons.favorite,
              text: "C A T E G O R Y",
            onTap:(){
              Navigator.pushNamed(context, '/category',arguments: AgrumentScreenCategory(comics));
            } ,
          ),
          MyListTitle(
            icon: Icons.history,
            text: "H I S T O R Y",
            onTap:(){
              Navigator.pushNamed(context, '/history',arguments: AgrumentScreenCategory(comics));
            } ,
          ),
          MyListTitle(
              icon: Icons.logout,
              text: "S I G N  O U T",
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },

          ),

        ],
      ),

    );
  }
}
