library state_manager;

import 'dart:async';

import 'package:dart_console/dart_console.dart';
import 'package:equatable/equatable.dart';
import 'package:html/dom.dart';

part 'event.dart';
part 'state.dart';

class StateManager {
  StateManager._();
  static StateManager? _instance;
  factory StateManager.instance() {
    return _instance ??= StateManager._();
  }

  State state = State();
  final StreamController<State> _stateStreamController =
      StreamController.broadcast();

  Stream<State> get stateStream => _stateStreamController.stream;

  void add(StateEvent event) {
    state = event.onEvent(state);
    _stateStreamController.add(state);
  }
}
