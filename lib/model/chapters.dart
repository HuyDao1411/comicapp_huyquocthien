

class Chapters{
  late List<dynamic> links;
  late String name;

  Chapters({required this.links,required this.name});

  Chapters.fromJson(Map<String,dynamic> json){
    if(json['Links']!=null){
      links = json['Links'];
      name = json['Name'];
  }else{
      name = json['Name'];
    }
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String,dynamic>{};
    data['Links']= links;
    data['Name']= name;
    return data;
  }

}