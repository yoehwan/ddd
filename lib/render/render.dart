import 'dart:async';

import 'package:dart_console/dart_console.dart';

class Render {
  Render(this.html);
  final String html;
  final console = Console();
  Future<bool> initProcess() async {
    try {
      _refresh();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void _refresh() {
    console.clearScreen();
    console.resetCursorPosition();
  }
}
