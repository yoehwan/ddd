library key_binder;

import 'package:dart_console/dart_console.dart';
import 'package:ddd/exception.dart';
import 'package:ddd/state_manager/state_manager.dart';

part 'key_bind_event.dart';

class KeyBinder {
  KeyBinder(this.keyStream);
  final Stream<Key> keyStream;
  final StateManager stateManager = StateManager.instance();

  void init() {
    keyStream.listen(onKey);
  }

  void onKey(Key key) {
    final state = stateManager.state;
    final status = state.status;
    final keyChar = key.char;
    if (key.controlChar == ControlCharacter.ctrlQ) {
      if (status != Status.web) {
        stateManager.addEvent(KeyBindOnTapWeb());
        return;
      }
      stateManager.addEvent(KeyBindOnTapExit());
      return;
    }
    switch (status) {
      case Status.request:
      case Status.render:
      case Status.loading:
      case Status.error:
        break;
      case Status.web:
        if (keyChar == ":") {
          stateManager.addEvent(KeyBindOnCommand());
          return;
        }
        if (keyChar == "?") {
          stateManager.addEvent(KeyBindOnHelp());
          return;
        }
        break;
      case Status.command:
        if (key.controlChar == ControlCharacter.enter) {
          stateManager.addEvent(KeyBindOnRunCommand());
          return;
        }
        stateManager.addEvent(KeyBindOnTapCommandKey(key));
        break;
      case Status.runCommand:
        final commandText = state.commandText;
        if (commandText.isEmpty) {
          return;
        }
        final list = commandText.split(" ");
        final command = list.first;
        final target = list.last;
        try {
          _runCommand(command, target);
        } on Exception catch (e) {
          stateManager.addEvent(KeyBindOnException(e));
        }
        return;
      case Status.search:
      case Status.help:
      case Status.exit:
    }
  }

  void _runCommand(String command, String target) {
    if (command == "G") {
      stateManager.addEvent(KeyBindOnRequestURL(target));
      return;
    }
    throw DDDUnknownCommandException(command);
  }
}
