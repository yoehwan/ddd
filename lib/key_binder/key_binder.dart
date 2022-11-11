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
        stateManager.add(KeyBindOnTapWeb());
        return;
      }
      stateManager.add(KeyBindOnTapExit());
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
          stateManager.add(KeyBindOnCommand());
          return;
        }
        if (keyChar == "?") {
          stateManager.add(KeyBindOnHelp());
          return;
        }
        break;
      case Status.command:
        if (key.controlChar == ControlCharacter.enter) {
          stateManager.add(KeyBindOnRunCommand());
          return;
        }
        stateManager.add(KeyBindOnTapCommandKey(key));
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
          stateManager.add(KeyBindOnException(e));
        }
        return;
      case Status.search:
      case Status.help:
      case Status.exit:
    }
  }

  void _runCommand(String command, String target) {
    if (command == "G") {
      stateManager.add(KeyBindOnRequestURL(target));
      return;
    }
    throw DDDUnknownCommandException(command);
  }
}
