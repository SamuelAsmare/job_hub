import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum SocketConnectionState {
  connecting,
  connected,
  disconnected,
  error,
}

class MessageSocketService {
  IO.Socket? _socket;

  SocketConnectionState _connectionState = SocketConnectionState.disconnected;

  final StreamController<SocketConnectionState> _stateController =
      StreamController<SocketConnectionState>.broadcast();

  final Map<String, StreamController<dynamic>> _eventControllers = {};

  SocketConnectionState get connectionState => _connectionState;

  Stream<SocketConnectionState> get connectionStateStream =>
      _stateController.stream;

  bool get isConnected => _socket?.connected ?? false;

  void connect({
    required String serverUrl,
    required String userId,
    String? token,
  }) {
    if (_socket != null) {
      disconnect();
    }

    _updateState(SocketConnectionState.connecting);

    final auth = <String, dynamic>{
      'userId': userId,
      if (token != null && token.isNotEmpty) 'token': token,
    };

    _socket = IO.io(
      serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth(auth)
          .build(),
    );

    _socket!
      ..onConnect((_) {
        _updateState(SocketConnectionState.connected);
      })
      ..onDisconnect((_) {
        _updateState(SocketConnectionState.disconnected);
      })
      ..onConnectError((_) {
        _updateState(SocketConnectionState.error);
      })
      ..onError((_) {
        _updateState(SocketConnectionState.error);
      });

    _socket!.connect();
  }

  Stream<dynamic> on(String eventName) {
    if (_socket == null) {
      throw StateError('Connect to the server before listening for events.');
    }

    if (_eventControllers.containsKey(eventName)) {
      return _eventControllers[eventName]!.stream;
    }

    final controller = StreamController<dynamic>.broadcast();
    _eventControllers[eventName] = controller;

    _socket!.on(eventName, (data) {
      if (!controller.isClosed) {
        controller.add(data);
      }
    });

    return controller.stream;
  }

  void emit(String eventName, dynamic data) {
    if (_socket == null) {
      throw StateError('Socket is not initialized.');
    }

    _socket!.emit(eventName, data);
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;

    for (final controller in _eventControllers.values) {
      controller.close();
    }

    _eventControllers.clear();

    _updateState(SocketConnectionState.disconnected);
  }

  void _updateState(SocketConnectionState state) {
    _connectionState = state;

    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  Future<void> dispose() async {
    disconnect();
    await _stateController.close();
  }
}
