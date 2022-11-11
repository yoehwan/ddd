library terminal;

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dart_console/dart_console.dart';
import 'package:ddd/state_manager/state_manager.dart';
import 'package:ddd/terminal/view/help_view/help_view.dart';
import 'package:ddd/terminal/view/loading_view/loading_view.dart';
import 'package:ddd/terminal/view/web_view/web_view.dart';

part 'terminal_event.dart';
part 'view/terminal_view.dart';

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
    Isolate.spawn(_spawnKeyListener, _port.sendPort);
  }

  void _stateListener(State state) {
    final previusStatus = state.previusStatus;
    final status = state.status;
    switch (status) {
      case Status.web:
        WebView(state.webText);
    final position = _console.cursorPosition;
    print(position);
        break;
      case Status.runCommand:
        break;
      case Status.command:
        if (previusStatus != status) {
          _commandView();
          return;
        }
        final key = state.pressedKey;
        if (key != null) {
          if (key.controlChar == ControlCharacter.backspace) {
            backspace(state.commandText);
            return;
          }
          write(key.char);
        }
        return;
      case Status.help:
        HelpView();
        return;
      case Status.error:
        WebView(state.webText);
        final e = state.exception;
        if (e != null) {
          _errorView(e);
        }
        return;
      case Status.search:
      case Status.loading:
      case Status.request:
      case Status.render:
        LoadingView();
        break;
      case Status.exit:
        dispose();
        return;
    }
  }

  void _errorView(Exception exception) {
    _console.resetCursorPosition();
    final height = _console.windowHeight;
    for (int index = 0; index < height; index++) {
      _console.cursorDown();
    }
    _console.setBackgroundColor(ConsoleColor.red);
    _console.write(exception.toString().split("\n").first);
    _console.resetColorAttributes();
  }

  void _commandView() {
    _console.resetCursorPosition();
    final height = _console.windowHeight;
    for (int index = 0; index < height; index++) {
      _console.cursorDown();
    }
    write(":");
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

  void backspace(String commandText) {
    final newCommand = commandText.substring(0, commandText.length );
    print(newCommand);
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
