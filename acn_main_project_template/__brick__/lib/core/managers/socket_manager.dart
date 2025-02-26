import 'dart:async';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:web_socket_channel/io.dart' show IOWebSocketChannel;
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart' show WebSocketChannelException;


class AutoReconnectWebSocket {
  final Uri _endpoint;
  final int delay;
  final StreamController<dynamic> _recipientCtrl = StreamController<dynamic>();
  final StreamController<dynamic> _sentCtrl = StreamController<dynamic>();
  bool isSafeClose = false;
  Function(bool isConnected)? connectionCallback;
  IOWebSocketChannel? webSocketChannel;
  StreamSubscription? _wbSubscription;

  Stream get stream => _recipientCtrl.stream; //for receive
  StreamSink get sink => _sentCtrl.sink; //for send

  AutoReconnectWebSocket(this._endpoint, {this.delay = 4}) {
    debugShow("Initialize AutoReconnectWebSocket");
    _sentCtrl.stream.listen((event) {
      webSocketChannel!.sink.add(event);
    });
  }

  bool get isConnected => webSocketChannel != null && webSocketChannel!.closeCode == null;

  void connect() async {
    try {
      webSocketChannel = IOWebSocketChannel.connect(_endpoint,connectTimeout: const Duration(seconds: 1),pingInterval: const Duration(seconds: 1));

      debugShow("WEB SOCKET IS CONNECTING");
      _wbSubscription = webSocketChannel!.stream.listen((event) {
        _recipientCtrl.add(event);
      }, onDone: () async {
        debugShow(webSocketChannel?.closeCode.toString());
        debugShow("WebSocket OnDone");
        debugShow(webSocketChannel?.closeReason.toString());
        if (isSafeClose == false) {
          await Future.delayed(Duration(seconds: delay));
          connect();
        } else {
          isSafeClose = false;
          debugShow("Socket Closed By User");
        }
      }, onError: (a, b) {
        connectionCallback?.call(false);
        debugShow("ON ERROR SOCKET ${a.toString()}\n and=> ${b.toString()}");
      }, cancelOnError: false);
      await webSocketChannel?.ready;
      connectionCallback?.call(true);
    } on WebSocketChannelException catch (e) {
      connectionCallback?.call(false);
      debugShow("WebSocketChannelException WebSocket HATA: ${e.toString()}");
    } catch (e) {
      connectionCallback?.call(false);
      debugShow("Error WebSocket HATA: ${e.toString()}");
    }
  }

  /// } on SocketException catch (e) {
  ///   // Handle the exception.
  /// } on WebSocketChannelException catch (e) {
  ///   // Handle the exception.
  /// }
  Future<void> closeWebSocket() async {
    isSafeClose = true;
    try {
      await webSocketChannel?.sink.close(status.goingAway, "handleClose");
      await _wbSubscription?.cancel();
      webSocketChannel = null;
      _wbSubscription = null;
      connectionCallback = null;
      if (!_recipientCtrl.isClosed) _recipientCtrl.close();
      if (!_sentCtrl.isClosed) _sentCtrl.close();
      debugShow("******Socket Closing******");
    } catch (e) {
      debugShow(e);
    }
  }
}
