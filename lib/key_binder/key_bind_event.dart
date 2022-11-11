part of key_binder;

abstract class KeyBindEvent extends StateEvent {}

class KeyBindOnException extends KeyBindEvent {
  KeyBindOnException(this.exception);
  final Exception exception;

  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.error,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [exception];
}

class KeyBindOnTapCommandKey extends KeyBindEvent {
  KeyBindOnTapCommandKey(this.key);
  final Key key;

  @override
  State onEvent(State state) {
    return state.copyWith(
      pressedKey: key,
      commandText: state.commandText + key.char,
    );
  }

  @override
  List<Object?> get props => [key];
}

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

class KeyBindOnHelp extends KeyBindEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.help,
    );
  }

  @override
  List<Object?> get props => [];
}

class KeyBindOnCommand extends KeyBindEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.command,
      commandText: "",
    );
  }

  @override
  List<Object?> get props => [];
}

class KeyBindOnRunCommand extends KeyBindEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.runCommand,
    );
  }

  @override
  List<Object?> get props => [];
}

class KeyBindOnTapWeb extends KeyBindEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.web,
    );
  }

  @override
  List<Object?> get props => [];
}

class KeyBindOnRequestURL extends KeyBindEvent {
  KeyBindOnRequestURL(this.url);
  final String url;

  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.request,
      url: url,
    );
  }

  @override
  List<Object?> get props => [url];
}

// TODO: make it handle by offset.
class KeyBindOnMoveCursor extends KeyBindEvent {
  KeyBindOnMoveCursor(this.key);
  final Key key;

  @override
  State onEvent(State state) {
    return state.copyWith(
        // status: Status.moveCusor,
        // pressedKey: key,
        );
  }

  @override
  List<Object?> get props => [];
}
