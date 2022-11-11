import 'package:ddd/exception.dart';
import 'package:ddd/parser/parser_event.dart';
import 'package:ddd/state_manager/state_manager.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;

const httpStatusOK = 200;

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
      case Status.runCommand:
        break;
      case Status.request:
        try {
          final url = state.url;
          final document = await _fetchHtml(url);
          stateManager.add(ParserOnCompleted(document));
          break;
        } on Exception catch (e) {
          stateManager.add(ParserOnError(e));
        }
    }
  }

  final dio = Dio();

  Future<Document> _fetchHtml(String url) async {
    try {
      final res = await dio.get(
        url,
        onReceiveProgress: (count, total) {},
      );
      if (res.statusCode == httpStatusOK) {
        String htmlToParse = res.data;
        return html.parse(htmlToParse);
      }
      throw DDDConnectionException("${res.statusCode}, ${res.statusMessage}");
    } catch (e) {
      throw DDDConnectionException(e.toString());
    }
  }
}
