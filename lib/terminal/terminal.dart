library terminal;

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dart_console/dart_console.dart';
import 'package:ddd/state_manager/state_manager.dart';
part 'terminal_event.dart';

final _console = Console();
void _spawnKeyListener(SendPort port) {
  while (true) {
    final key = _console.readKey();
    port.send(key);
  }
}

class Terminal {
  final StateManager stateManager = StateManager.instance();

  final _port = ReceivePort();
  Stream<Key> get keyStream => _port.map((event) => event as Key);
  void init() {
    stateManager.stateStream.listen(_stateListener);
    keyStream.listen(_keyListener);
    Isolate.spawn(_spawnKeyListener, _port.sendPort);
  }

  void _keyListener(Key key) {
    stateManager.add(TerminalOnKey(key));
  }

  void _stateListener(State state) {
    final status = state.status;
    final key = state.pressedKey;
    switch (status) {
      case Status.init:
        // TODO: Handle this case.
        break;
      case Status.help:
        write("Help Text", clear: true);
        break;
      case Status.tapKey:
        // TODO: Handle this case.
        break;
      case Status.exit:
        dispose();
        break;
      case Status.moveCusor:
        if (key == null) {
          return;
        }
        final arrow = key.controlChar;
        switch (arrow) {
          case ControlCharacter.arrowLeft:
            _console.cursorLeft();
            break;
          case ControlCharacter.arrowUp:
            _console.cursorUp();
            break;
          case ControlCharacter.arrowRight:
            _console.cursorRight();
            break;
          case ControlCharacter.arrowDown:
            _console.cursorDown();
            break;
          default:
            break;
        }
        break;
      case Status.command:
        if (key != null) {
          _commandMode(key);
        }
        return;
    }
    if (key != null) {
      _console.write(key);
    }
  }

  void _commandMode(Key key) {
    _console.resetCursorPosition();
    final height = _console.windowHeight;
    for (int index = 0; index < height; index++) {
      _console.cursorDown();
    }
    _console.write(":");
  }

  Future refresh([String? html]) async {
    _clearScreen();
    if (html == null) {
      return;
    }
    _console.write(html);
    _console.resetCursorPosition();
  }

  void write(
    String text, {
    bool clear = false,
  }) {
    if (clear) {
      _clearScreen();
    }
    _console.write(text);
  }

  void dispose() {
    _clearScreen();
    _console.rawMode = false;
    exit(1);
  }

  void _clearScreen() {
    _console.clearScreen();
    _console.resetCursorPosition();
  }
}
