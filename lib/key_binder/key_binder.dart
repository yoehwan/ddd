library key_binder;

import 'package:dart_console/dart_console.dart';
import 'package:ddd/state_manager/state_manager.dart';

part 'key_bind_event.dart';

class KeyBinder {
  final StateManager stateManager = StateManager.instance();

  void init() {
    stateManager.stateStream.listen(_stateListener);
  }

  void _stateListener(State state) {
    final key = state.pressedKey;
    if (key != null) {
      onKey(key);
    }
  }

  void onKey(Key key) {
    final state = stateManager.state;
    final status = state.status;
    final keyChar = key.char;
    if (key.controlChar == ControlCharacter.ctrlQ) {
      stateManager.add(KeyBindOnTapExit());
      return;
    }
    switch (status) {
      case Status.web:
        if (keyChar == ":") {
          stateManager.add(KeyBindOnTapCommand());
          return;
        }
        if (keyChar == "?") {
          stateManager.add(KeyBindOnTapHelp());
          return;
        }
        break;
      case Status.command:
        if (key.controlChar == ControlCharacter.enter) {
          stateManager.add(KeyBindOnTapWeb());
          return;
        }
        break;
      case Status.help:
      case Status.exit:
      case Status.loading:
      case Status.search:
      case Status.request:
      case Status.render:
      case Status.error:
        break;
      case Status.runCommand:
        print(state.commandText);
        break;
    }
  }
}
