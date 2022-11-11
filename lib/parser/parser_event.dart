import 'package:ddd/exception.dart';
import 'package:ddd/state_manager/state_manager.dart';
import 'package:html/dom.dart';

abstract class ParserEvent extends StateEvent {}

class ParserOnCompleted extends ParserEvent {
  ParserOnCompleted(this.document);
  final Document document;

  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.render,
      document: document,
    );
  }

  @override
  List<Object?> get props => [document];
}

class ParserOnError extends ParserEvent {
  ParserOnError(this.exception);
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
