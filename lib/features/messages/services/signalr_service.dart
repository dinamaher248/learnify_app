// Placeholder SignalR service.
// NOTE: Real SignalR or WebSocket integration requires adding an
// appropriate package (for example `signalr_core`) and handling
// authentication headers. This file intentionally avoids importing
// external packages so analysis stays green until you decide which
// real-time client to use.

import 'dart:async';

class SignalRService {
  final String hubUrl;
  bool _started = false;

  SignalRService(this.hubUrl);

  Future<void> start() async {
    // TODO: implement real SignalR/WebSocket connection using a
    // chosen package and ensure Authorization headers are set.
    _started = true;
  }

  void on(String method, void Function(List<Object?> args) callback) {
    // TODO: register a callback for server-sent events.
  }

  Future<void> stop() async {
    _started = false;
  }
}
