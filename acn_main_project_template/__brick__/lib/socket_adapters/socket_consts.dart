class SocketConstant {
  static SocketConstant get instance => SocketConstant._init();
  SocketConstant._init();
  final String _scheme = "wss";
  final String _host = "echo.websocket.org";
  final String _path = "";
  Uri messageSocketURI() {
    return Uri(scheme: _scheme, host: _host, path: _path, queryParameters: {});
  }
}
