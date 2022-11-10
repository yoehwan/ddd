library key_binder;

import 'package:dart_console/dart_console.dart';
import 'package:ddd/state_manager/state_manager.dart';

part 'key_bind_event.dart';

const _helpText = "Help Text";

class KeyBinder {
  final StateManager stateManager = StateManager.instance();

  void init() {
    stateManager.stateStream.listen(_stateListener);
  }

  void _stateListener(State state) {
    final status = state.status;
    switch (status) {
      case Status.init:
        // TODO: Handle this case.
        break;
      case Status.help:
        // TODO: Handle this case.
        break;
      case Status.tapKey:
        final key = state.pressedKey;
        if (key == null) {
          return;
        }
        onKey(key);
        break;
      case Status.exit:
        // TODO: Handle this case.
        break;
    }
  }

  void onKey(Key key) {
    if (key.isControl) {
      switch (key.controlChar) {
        case ControlCharacter.ctrlQ:
          stateManager.add(KeyBindOnTapExit());
          break;
        case ControlCharacter.ctrlS:
          // editorSave();
          break;
        case ControlCharacter.ctrlF:
          // editorFind();
          break;
        case ControlCharacter.backspace:
        case ControlCharacter.ctrlH:
          // editorBackspaceChar();
          break;
        case ControlCharacter.delete:
          // editorMoveCursor(ControlCharacter.arrowRight);
          // editorBackspaceChar();
          break;
        case ControlCharacter.enter:
          // editorInsertNewline();
          break;
        case ControlCharacter.arrowLeft:
        case ControlCharacter.arrowUp:
        case ControlCharacter.arrowRight:
        case ControlCharacter.arrowDown:
          stateManager.add(KeyBindOnMoveCursor(key));
          break;
        case ControlCharacter.ctrlA:
          // editorMoveCursor(ControlCharacter.home);
          break;
        case ControlCharacter.ctrlE:
          // editorMoveCursor(ControlCharacter.end);
          break;
        default:
      }
    } else {
      final keyChar = key.char;
      if (keyChar == "?") {
        stateManager.add(KeyBindOnTapHelp());
        return;
      }
      if (keyChar == ":") {
        stateManager.add(KeyBindOnTapCommand());
        return;
      }
    // stateManager.add(KeyBindOnTapKey(key));
    }
  }
}
