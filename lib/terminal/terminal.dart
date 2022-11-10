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
    final previusStatus = state.previusStatus;
    final status = state.status;
    switch (status) {
      case Status.web:
      case Status.runCommand:
        _webView(state.webText);
        return;
      case Status.command:
        if (previusStatus != status) {
          _commandView();
          return;
        }
        final key = state.pressedKey;
        if (key != null) {
          final char = key.char;
          final controlChar = key.controlChar;
          if (controlChar == ControlCharacter.enter) {
            stateManager.add(TerminalOnTapCommand(_commandText));
            return;
          }
          if (controlChar == ControlCharacter.backspace) {
            // how Delete char on carrot?
            return;
          }
          if (controlChar == ControlCharacter.arrowLeft) {
            _console.cursorLeft();
            return;
          }
          if (controlChar == ControlCharacter.arrowRight) {
            _console.cursorRight();
            return;
          }
          write(char);
          _commandText += char;
        }
        return;
      case Status.help:
        _helpView();
        return;
      case Status.exit:
        dispose();
        return;
      case Status.loading:
        _loadingView();
        break;
      case Status.error:
        final e = state.exception;
        if (e != null) {
          _errorView(e);
        }
        return;
      case Status.search:
      case Status.request:
      case Status.render:
        break;
    }
  }

  void _errorView(Exception exception) {
    _console.resetCursorPosition();
    final height = _console.windowHeight;
    for (int index = 0; index < height; index++) {
      _console.cursorDown();
    }
    _console.setBackgroundColor(ConsoleColor.red);
    _console.write(exception.toString());
    _console.resetColorAttributes();
  }

  void _loadingView() {
    write("Loading..", clear: true);
  }

  void _webView(String webText) {
    write(webText, clear: true);
  }

  String _commandText = "";
  void _commandView() {
    _commandText = ":";
    _console.resetCursorPosition();
    final height = _console.windowHeight;
    for (int index = 0; index < height; index++) {
      _console.cursorDown();
    }
    write(":");
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

  void _helpView() {
    write("Help Text", clear: true);
  }
}
