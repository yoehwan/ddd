part of terminal;

abstract class TerminalEvent extends StateEvent {}

class TerminalOnKey extends TerminalEvent {
  TerminalOnKey(this.key);
  final Key key;
  @override
  List<Object?> get props => [key];

  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.tapKey,
      pressedKey: key,
    );
  }
}
