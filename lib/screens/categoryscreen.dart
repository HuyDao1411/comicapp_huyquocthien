import 'package:comicappver2/user_auth/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/chapters.dart';
import '../state/agrument.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<bool> check=[];
  late DatabaseReference dbRef;
  final currentUser=FirebaseAuth.instance.currentUser;
  late String name;
  late final snapshot;
  var data;

  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)?.settings.arguments as AgrumentScreenCategory;
    dbRef = FirebaseDatabase.instance.ref().child('lovecategory');



    List<Chapters>? chapters2;
    var matchQuery=[];
    var img=[];
    var category=[];
    var items=[];
    for (var item in args.comics){
      matchQuery.add(item.name);
      chapters2=item.chapters;
      img.add(item.image);
      category.add(item.category);
      items.add(item);
      check.add(false);
    }
    return Scaffold(
          appBar: AppBar(
            title: Text('List Comic'),
            backgroundColor: Colors.red,
          ),
          backgroundColor:  Colors.white,

          body:
          ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context,index){
              var result =matchQuery[index];
              return ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey  ,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                title: Text('${result}',style: TextStyle(fontWeight: FontWeight.bold,),
                ),
                leading: Image.network(img[index].toString()),
                subtitle: Text('${category[index]}'),
                trailing: GestureDetector(
                  onTap: (){
                    setState(() {
                      check[index]=!check[index];
                      name=matchQuery[index];
                    });
                    if(check[index]==false){
                      deleteComic(index);
                    }else {
                      uploadComic('${currentUser?.email}', index, items[index]);
                    }
                  },
                  child: Icon(check[index]? Icons.favorite:Icons.favorite_border,color: check[index]==false ?Colors.grey:Colors.red,),
                )
              );
            },
          ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
            Navigator.pushNamed(context, '/viewLoveCate',arguments: AgrumentScreenCategory(args.comics));
          }, label: Text('Favorites')),
      );


  

    

  }
  uploadComic(String currentUser,int Index,var item) async {
    Map<String, dynamic> Comicc = {
      'user':currentUser,
      'name':name,
      'image':item.image,
    };
    dbRef.child('${currentUser.split('@')[0]}').child("${Index}").set(Comicc).whenComplete(() {
      showToast(message: 'Upload');
    });
  }
  deleteComic(int Index) async {
    dbRef.child('${currentUser?.email?.split('@')[0]}').child("${Index}").remove().whenComplete(() {
      showToast(message: 'Delete');
    });
  }
}

// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('${result} đã được thêm vào danh sách yêu thích.'),),);}