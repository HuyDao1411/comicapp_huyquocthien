
import 'package:comicappver2/model/chapters.dart';
import 'package:flutter/material.dart';
import '../state/agrument.dart';
import '../model/comic.dart';

class CustomSearch extends SearchDelegate{
  late List<Comic> comics;
  CustomSearch(this.comics);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
            query='';
          },
          icon: Icon(Icons.clear))
    ];
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed:(){
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Chapters>? chapters2;
    var matchQuery=[];
    var img=[];
    var category=[];
    for (var item in comics){
      if(item.name!.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item.name);
        chapters2=item.chapters;
        img.add(item.image);
        category.add(item.category);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
        var result =matchQuery[index];
        return ListTile(
          title: Text('${result}'),
          leading: Image.network(img[index].toString()),
          subtitle: Text('${category[index]}'),
          onTap: (){
            Navigator.pushNamed(context,"/chapters",arguments: AgrumentScreen(chapters2,result));
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Chapters>? chapters2;
    var matchQuery=[];
    var img=[];
    var category=[];
    for (var item in comics){
      if(item.name!.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item.name);
        chapters2=item.chapters;
        img.add(item.image);
        category.add(item.category);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
        var result =matchQuery[index];
        return ListTile(
          title: Text('${result}'),
          leading: Image.network(img[index].toString()),
          subtitle: Text('${category[index]}'),
          onTap: (){
            Navigator.pushNamed(context,"/chapters",arguments: AgrumentScreen(chapters2,result));
          },
        );
      },
    );
  }
}
