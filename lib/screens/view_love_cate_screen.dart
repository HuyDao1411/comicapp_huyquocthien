import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ViewLoveCate extends StatefulWidget {
  const ViewLoveCate({super.key});

  @override
  State<ViewLoveCate> createState() => _ViewLoveCateState();
}

class _ViewLoveCateState extends State<ViewLoveCate> {
  final currentUser=FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('lovecategory/${currentUser?.email?.split('@')[0]}');


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My love comic',
        ),
        backgroundColor: Colors.red,
      ),
      body: FirebaseAnimatedList(
        query: dbRef,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          Map loadComic = snapshot.value as Map;
          loadComic['key'] = snapshot.key;
          return GestureDetector(
            onTap: () {},
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    ),
                    onPressed: () {
                      dbRef.child(loadComic['key']).remove();
                    },
                  ),
                  leading: Image.network(loadComic['image']),
                  title: Text(
                    loadComic['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    loadComic['user'],

                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
