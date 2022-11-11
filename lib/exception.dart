abstract class DDDException implements Exception {
  DDDException(this.message);
  final String message;
  @override
  String toString() {
    return "$runtimeType: $message";
  }
}

class DDDUnknownException extends DDDException {
  DDDUnknownException() : super("Unknown Exception");
}

class DDDUnknownCommandException extends DDDException {
  DDDUnknownCommandException(this.command)
      : super("Unknown Command Exception : [$command]");
  final String command;
}

class DDDConnectionException extends DDDException {
  DDDConnectionException(super.message);
}
