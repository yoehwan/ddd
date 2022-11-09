import 'package:ddd/exception.dart';
import 'package:ddd/render/render.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html show parse;

Future<void> main(List<String> arguments) async {
  // if (arguments.isEmpty) {
  //   throw ArgumentError();
  // }
  // final url = arguments.first;
  // if (!isURl(url)) {
  //   throw URLValidExection();
  // }
  final render = Render("");
  render.initProcess();
  
  final res = await http.get(Uri.parse(arguments.first));
  if (res.statusCode == 200) {
    String htmlToParse = res.body;
    final doc = html.parse(htmlToParse);
    print(doc);
  }
}

bool isURl(String url) {
  return RegExp(
          r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
      .hasMatch(url);
}
