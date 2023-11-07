
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../state/agrument.dart';

class ChapterScreen extends StatelessWidget{
  ChapterScreen({super.key});
  final currentUser=FirebaseAuth.instance.currentUser;
  late DatabaseReference dbRef;
  @override
  Widget build(BuildContext context) {
    dbRef = FirebaseDatabase.instance.ref().child('history');
    final args=ModalRoute.of(context)?.settings.arguments as AgrumentScreen;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF44A3E),
        title: Text(args.name.toString()),
      ),
      body: args.chapters != null && args.chapters!.length>0
        ? Padding(padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: args.chapters?.length,
          itemBuilder: (context,index){
            return GestureDetector(onTap: (){
              deleteHistory(index);
              uploadHistory(currentUser!.email.toString(), index, args.name, args.chapters?[index].name);
              Navigator.pushNamed(context, '/read',arguments: AgrumentScreenRead(args.chapters,args.chapters?[index].name,args.chapters?[index].links));

            },
              child: Column(
              children: [
                  ListTile(title: Text('${args.chapters?[index].name}'),),
                  Divider(thickness: 1)
              ],
            ),
            );
          }
        ),
      )
          :Center(
            child: Text('Đang cập nhật'),
      ),
    );
  }
  uploadHistory(String currentUser,int Index,var nameComic,var nameChapter) async {
    Map<String, dynamic> Comicc = {
      'user':currentUser,
      'nameComic':nameComic,
      'nameChapter':nameChapter,
    };
    dbRef.child('${currentUser.split('@')[0]}').child("${Index}").set(Comicc).whenComplete(() {
    });
  }
  deleteHistory(int Index) async {
    dbRef.child('${currentUser?.email?.split('@')[0]}').child("${Index}").remove().whenComplete(() {
    });
  }

}




