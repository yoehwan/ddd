import 'package:ddd/key_binder/key_binder.dart';
import 'package:ddd/parser/parser.dart';
import 'package:ddd/render/render.dart';
import 'package:ddd/terminal/terminal.dart';

Future<void> main(List<String> arguments) async {
  // if (arguments.isEmpty) {
  //   throw ArgumentError();
  // }
  // final url = arguments.first;
  // if (!isURl(url)) {
  //   throw URLValidExection();
  // }

  final url = "https://google.com";
  final parser = Parser();
  final document = await parser.fetchHtml(url);
  if (document == null) {
    print("doc is null");
    return;
  }
  final render = Render();
  final html = render.init(document);
  final terminal = Terminal();
  final keyBinder = KeyBinder();
  keyBinder.init();
  terminal.init();
  terminal.refresh(html);
}
