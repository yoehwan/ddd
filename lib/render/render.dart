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
      case Status.request:
        // TODO: Handle this case.
        break;
      case Status.render:
        final doc = state.document;
        if (doc != null) {
          final html = rendering(doc);
          stateManager.add(RenderOnCompleted(html));
        }
        break;
      case Status.loading:
        // TODO: Handle this case.
        break;
      case Status.web:
        // TODO: Handle this case.
        break;
      case Status.command:
        // TODO: Handle this case.
        break;
      case Status.search:
        // TODO: Handle this case.
        break;
      case Status.help:
        // TODO: Handle this case.
        break;
      case Status.exit:
        // TODO: Handle this case.
        break;
    }
  }

  String rendering(Document document) {
    return document.getElementsByTagName("a").map((e) => e.text).join(" ");
  }
}
