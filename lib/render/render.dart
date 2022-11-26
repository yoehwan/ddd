import 'package:ddd/render/render_event.dart';
import 'package:ddd/state_manager/state_manager.dart';
import 'package:html/dom.dart';

class Render {
  final StateManager stateManager = StateManager.instance();

  void init() {
    stateManager.stateStream.listen(_stateListener);
  }

  void _stateListener(State state) {
    final status = state.status;
    switch (status) {
      case Status.render:
        final doc = state.document;
        if (doc != null) {
          final html = rendering(doc);
          stateManager.addEvent(RenderOnCompleted(html));
        }
        break;
      case Status.request:
      case Status.loading:
      case Status.web:
      case Status.command:
      case Status.search:
      case Status.help:
      case Status.exit:
      case Status.error:
      case Status.runCommand:
        break;
    }
  }

  String rendering(Document document) {
    return document.getElementsByTagName("a").map((e) => e.text).join(" ");
  }
}
