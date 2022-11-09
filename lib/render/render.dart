import 'package:html/dom.dart';

class Render {
  String init(Document document) {
    return document.getElementsByTagName("a").map((e)=>e.text).join(" ");
  }
}
