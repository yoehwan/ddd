part of state_manager;

enum Status {
  request,
  render,
  loading,
  error,
  web,
  command,
  runCommand,
  search,
  help,
  exit,
}

class State extends Equatable {
  State({
    this.url = "",
    this.document,
    this.previusStatus = Status.loading,
    this.status = Status.web,
    this.webText = "",
    this.exception,
    this.pressedKey,
    this.commandText = "",
  });
  final Document? document;
  final String url;
  final Status previusStatus;
  final Status status;
  final String webText;
  final Exception? exception;
  final Key? pressedKey;
  final String commandText;
  @override
  List<Object?> get props => [
        document,
        url,
        previusStatus,
        status,
        exception,
        pressedKey,
        webText,
        commandText,
      ];
  State copyWith({
    Document? document,
    String? url,
    Status? status,
    Exception? exception,
    Key? pressedKey,
    String? webText,
    String? commandText,
  }) {
    return State(
      document: document ?? this.document,
      url: url ?? this.url,
      previusStatus: this.status,
      status: status ?? this.status,
      webText: webText ?? this.webText,
      exception: exception ?? this.exception,
      pressedKey: pressedKey ?? this.pressedKey,
      commandText: commandText ?? this.commandText,
    );
  }
}
