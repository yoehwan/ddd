import 'package:dart_console/dart_console.dart';
import 'package:ddd/terminal/terminal.dart';

class LoadingView extends TerminalView {
  @override
  void build(Console console) {
    write("Loading..");
  }
}
