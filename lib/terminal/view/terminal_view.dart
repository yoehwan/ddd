part of terminal;

abstract class TerminalView {
  TerminalView() {
    build(_console);
  }

  void clearScreen() {
    _console.clearScreen();
    _console.resetCursorPosition();
  }

  void write(
    String text, {
    bool clear = true,
  }) {
    if (clear) {
      clearScreen();
    }
    _console.write(text);
  }

  void build(Console console);
}
