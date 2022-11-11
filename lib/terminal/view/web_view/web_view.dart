import 'package:dart_console/dart_console.dart';
import 'package:ddd/terminal/terminal.dart';

class WebView extends TerminalView {
  WebView(this.html);
  final String html;

  @override
  void build(Console console) {
    write(html);
  }
}
