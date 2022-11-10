// import 'package:http/http.dart' as http;

import 'package:ddd/exception.dart';
import 'package:ddd/parser/parser_event.dart';
import 'package:ddd/state_manager/state_manager.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;

const httpStatusOK = 200;
const urlRegex =
    r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';

class Parser {
  final StateManager stateManager = StateManager.instance();
  void init() {
    stateManager.stateStream.listen(_stateListener);
  }

  void _stateListener(State state) async {
    final status = state.status;
    switch (status) {
      case Status.loading:
      case Status.render:
      case Status.web:
      case Status.command:
      case Status.search:
      case Status.help:
      case Status.exit:
      case Status.error:
        break;
      case Status.request:
        final url = state.url;
        final document = await _fetchHtml(url);
        if (document == null) {
          return;
        }
        stateManager.add(ParserOnCompleted(document));
        break;
    }
  }

  final dio = Dio();
  bool isURl(String url) {
    return RegExp(urlRegex).hasMatch(url);
  }

  Future<Document?> _fetchHtml(String url) async {
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
