import 'dart:async';

import 'package:dart_console/dart_console.dart';

class Terminal {
  final console = Console();
  Future refresh([String? html]) async {
    _clearScreen();
    if (html == null) {
      return;
    }
    console.write(html);
    console.write("\n");
  }

  void _clearScreen() {
    console.clearScreen();
    console.resetCursorPosition();
  }
}
