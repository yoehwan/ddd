part of state_manager;

abstract class StateEvent extends Equatable {
  State onEvent(State state);
}
