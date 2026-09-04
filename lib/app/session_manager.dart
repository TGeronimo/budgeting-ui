import 'dart:async';
import 'dart:js_interop';

class SessionManager {

  static final SessionManager instance = SessionManager._internal();
  SessionManager._internal();

  final _controller = StreamController<void>.broadcast();

  Stream<void> onSessionExpired() => _controller.stream;

  void notifySessionExpired() {
    _controller.add(null);
  }

}