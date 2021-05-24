import 'dart:async';

enum CounterAction {
  Increment,Decrement,Reset
}

class CounterBloc {
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get sinkState => _stateStreamController.sink;
  Stream<int> get streamState => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get sinkEvent => _eventStreamController.sink;
  Stream<CounterAction> get streamEvent => _eventStreamController.stream;

  CounterBloc() {
    int counter = 0;
    streamEvent.listen((event) {
      if(event == CounterAction.Increment) {
        counter++;
      } else if(event == CounterAction.Decrement) {
        counter--;
      } else if(event == CounterAction.Reset) {
        counter = 0;
      }
      sinkState.add(counter);
    });
  }
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}