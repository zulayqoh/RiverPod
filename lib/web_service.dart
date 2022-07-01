

abstract class WebSocketClient {
  Stream<int> getCounterStream();
}

class FakeWebSocketClient implements WebSocketClient {
  @override
  Stream<int> getCounterStream() async*{
    int i = 0;
    while(true) {
      await Future.delayed(Duration(milliseconds: 500));
      yield i++;
    }
  }
}