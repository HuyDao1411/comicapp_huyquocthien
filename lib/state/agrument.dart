import '../model/chapters.dart';
import '../model/comic.dart';

class AgrumentScreen {
  List<Chapters>? chapters;
  String? name;
  AgrumentScreen(this.chapters,this.name);
}
class AgrumentScreenRead {
  List<Chapters>? chapters;
  String? name;
  var links;
  AgrumentScreenRead(this.chapters,this.name,this.links);
}

class AgrumentScreenCategory{
  late List<Comic> comics;

  AgrumentScreenCategory(this.comics);

}