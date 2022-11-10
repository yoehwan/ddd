abstract class DDDException implements Exception {
  DDDException(this.message);
  final String message;
  @override
  String toString() {
    return "DDDError : $message";
  }
}

class DDDUnknownException extends DDDException {
  DDDUnknownException():super("UnknownException");
}
