part of key_binder;

abstract class KeyBindEvent extends StateEvent {}

class KeyBindOnTapExit extends KeyBindEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.exit,
    );
  }

  @override
  List<Object?> get props => [];
}

class KeyBindOnTapHelp extends KeyBindEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.help,
    );
  }

  @override
  List<Object?> get props => [];
}

class KeyBindOnTapCommand extends KeyBindEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.command,
    );
  }

  @override
  List<Object?> get props => [];
}

// TODO: make it handle by offset.
class KeyBindOnMoveCursor extends KeyBindEvent {
  KeyBindOnMoveCursor(this.key);
  final Key key;

  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.moveCusor,
      pressedKey: key,
    );
  }

  @override
  List<Object?> get props => [];
}
