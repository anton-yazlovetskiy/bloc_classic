import 'package:flutter/material.dart';
import 'package:streams/test_block.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = ExampleBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.outputStateStream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${snapshot.data}'),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        _bloc.inputEventSink.add(BlocEvents.eventOne),
                    child: const Text('+')),
                const SizedBox(
                  width: 50.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      debugPrint('1');
                      _bloc.inputEventSink.add(BlocEvents.eventTwo);
                    },
                    child: const Text('-')),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int param = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('$param'),
        ElevatedButton(
            onPressed: () {
              setState(() {
                param++;
              });
            },
            child: const Text('+'))
      ],
    );
  }
}
