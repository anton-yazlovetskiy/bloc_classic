import 'dart:async';

enum BlocEvents { eventOne, eventTwo } //Перечень возможных событий

class ExampleBloc {
  int _counter = 0;

  //Входной поток
  final _inputEventController = StreamController<BlocEvents>();
  StreamSink<BlocEvents> get inputEventSink => _inputEventController.sink;

  //выходной поток
  final _outputStateController = StreamController<int>.broadcast();
  //StreamSink<int> get _inCounter => _outputStateController.sink;
  Stream<int> get outputStateStream => _outputStateController.stream;

  //Конструктор прослушивающий входные события
  ExampleBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  //Бизнес-логика преобразующая поток входных событий в состояния передаваемые обратно
  void _mapEventToState(BlocEvents event) {
    if (event == BlocEvents.eventOne) {
      _counter++;
    } else if (event == BlocEvents.eventTwo) {
      _counter--;
    } else {
      throw Exception('Wrong eevent type');
    }
    _outputStateController.sink.add(_counter);
  }

  //Защита от утечек памяти
  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
