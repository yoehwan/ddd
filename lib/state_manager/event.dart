part of state_manager;

abstract class StateEvent extends Equatable {
  State onEvent(State state);
}

class StateExceptionEvent extends StateEvent {
  final Exception exception;

  StateExceptionEvent(this.exception);
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
