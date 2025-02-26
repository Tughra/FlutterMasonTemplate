import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../core/managers/socket_manager.dart';
import 'socket_consts.dart';

enum MessagingSocketState {
  connectionOpen,
  connectionClosed,
}

typedef MessagingStateCallback = void Function(MessagingSocketState state);
typedef ReceivedDataCallBack = void Function(String info, Map<String, dynamic> data);
typedef MessageDetailCallback = void Function(String info, Map<String, dynamic> receivedData);

class MessagingAdaptor {
  static MessagingAdaptor get instance => _instance;
  static final MessagingAdaptor _instance = MessagingAdaptor._init();

  MessagingAdaptor._init();

  //List<MessageAdapter> _catchedMessage = [];
  AutoReconnectWebSocket? _webSocket;
  Function(bool isConnected)? connectionCallback;
  void Function(String uID, String? image)? otherUserImageChanged;
  final JsonEncoder _encoder = const JsonEncoder();
  final JsonDecoder _decoder = const JsonDecoder();
  List<String> senderDataUIDs = [];
  StreamController<Map<String, dynamic>> receivedMessageStream = StreamController<Map<String, dynamic>>.broadcast();
  BehaviorSubject<bool> socketStatus = BehaviorSubject<bool>()
    ..value = false;

  void _initializeCallbacks() {
    _webSocket?.stream.listen((event) {
      onMessage(_decoder.convert(event));

      //print(event);
    });
    _webSocket?.connectionCallback = (isConnected) {
      debugPrint("webSocket.connectionCallback $isConnected");
      connectionCallback?.call(isConnected);
      socketStatus.sink.add(isConnected);
    };
  }

  void _sentToSocket(Map<String, dynamic> sendData) {
    _webSocket?.sink.add(_encoder.convert(sendData));
  }

  void connect({
    required String name,
    required String userId,
  }) async {
    if (receivedMessageStream.isClosed) receivedMessageStream = StreamController<Map<String, dynamic>>.broadcast();
    if (socketStatus.isClosed) socketStatus = BehaviorSubject<bool>();
    _webSocket = AutoReconnectWebSocket(SocketConstant.instance.messageSocketURI());
    _initializeCallbacks();
    _webSocket?.connect();
  }

  void closeSocket({required bool isSafe}) {
    _webSocket?.closeWebSocket();
    _webSocket = null;
    receivedMessageStream.close();
    socketStatus.close();
  }

  void onMessage(Map<String, dynamic> mapData) async {
    debugPrint("Message Adaptor => ${mapData.toString()}");
    //String command = mapData['type'];
    receivedMessageStream.add(mapData);
    //log(mapData.toString());
    //debugPrint('current command is ' + command);
  }

  registerRoom() {
    _sentToSocket({"action": "join-room", "message": "roomMerged"});
  }

  void sentSocket({required Map<String, dynamic> request}) {
    debugPrint("Is _webSocket == null --> ${_webSocket == null}");
    debugPrint("Is _webSocket?.sink == null --> ${_webSocket?.sink == null}");
    debugPrint("Is _webSocket?.stream == null --> ${_webSocket?.stream == null}");
    _sentToSocket(request);
  }

}