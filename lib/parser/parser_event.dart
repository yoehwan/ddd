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
