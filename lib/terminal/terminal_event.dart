part of terminal;

abstract class TerminalEvent extends StateEvent {}

class TerminalOnWeb extends TerminalEvent {
  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.web,
    );
  }

  @override
  List<Object?> get props => [];
}
