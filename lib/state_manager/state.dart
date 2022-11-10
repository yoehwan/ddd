part of state_manager;

enum Status {
  init,
  help,
  tapKey,
  moveCusor,
  command,
  exit,
}

class State extends Equatable {
  State({
    this.status = Status.init,
    this.pressedKey,
  });
  final Status status;
  final Key? pressedKey;
  @override
  List<Object?> get props => [
        status,
        pressedKey,
      ];
  State copyWith({
    Status? status,
    Key? pressedKey,
  }) {
    return State(
      status: status ?? this.status,
      pressedKey: pressedKey ?? this.pressedKey,
    );
  }
}
