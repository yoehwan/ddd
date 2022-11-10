import 'package:ddd/state_manager/state_manager.dart';

abstract class RenderEvent extends StateEvent {}

class RenderOnCompleted extends RenderEvent {
  RenderOnCompleted(this.html);
  final String html;

  @override
  State onEvent(State state) {
    return state.copyWith(
      status: Status.web,
      webText: html,
    );
  }

  @override
  List<Object?> get props => [html];
}
