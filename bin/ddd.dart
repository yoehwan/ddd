import 'package:ddd/key_binder/key_binder.dart';
import 'package:ddd/logger/logger.dart';
import 'package:ddd/parser/parser.dart';
import 'package:ddd/render/render.dart';
import 'package:ddd/state_manager/state_manager.dart';
import 'package:ddd/terminal/terminal.dart';

Future<void> main(List<String> arguments) async {
  final logger = Logger();
  logger.init();
  final url = "https://google.com";
  final parser = Parser();
  parser.init();
  final render = Render();
  render.init();
  final terminal = Terminal();
  terminal.init();
  final keyBinder = KeyBinder(terminal.keyStream);
  keyBinder.init();
  final stateManager = StateManager.instance();
  stateManager.add(KeyBindOnRequestURL(url));
}
