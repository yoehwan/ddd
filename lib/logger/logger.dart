import 'dart:io';

import 'package:ddd/state_manager/state_manager.dart';

class Logger {
  final StateManager stateManager = StateManager.instance();

  void init() {
    stateManager.stateStream.listen(_stateListener);
  }

  void _stateListener(State state) {
    final status = state.status;
    switch (status) {
      case Status.request:
      case Status.render:
      case Status.loading:
      case Status.web:
      case Status.command:
      case Status.runCommand:
      case Status.search:
      case Status.help:
      case Status.exit:
        break;
      case Status.error:
        final e = state.exception;
        if (e == null) {
          return;
        }
        _writeLog(e.toString());
    }
  }

  void _writeLog(String text) {
    final File file = File("./log");
    final isExist = file.existsSync();
    if (!isExist) {
      file.createSync();
    }
    file.writeAsString(text);
  }
}
