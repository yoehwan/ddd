// import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;

const httpStatusOK = 200;
const urlRegex =
    r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';

class Parser {
  Parser();

  bool isURl(String url) {
    return RegExp(urlRegex).hasMatch(url);
  }

  final dio = Dio();
  Future<Document?> fetchHtml(String url) async {
    final res = await dio.get(
      url,
      onReceiveProgress: (count, total) {},
    );

    if (res.statusCode == httpStatusOK) {
      String htmlToParse = res.data;
      return html.parse(htmlToParse);
    }
    return null;
  }
}
