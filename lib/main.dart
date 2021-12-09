import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ScopedBuilder(
              store: counter,
              onState: (context, state) => Text(
                '$state',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: counter.back,
            tooltip: 'Back',
            child: const Text("Back"),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Counter extends StreamStore<Exception, int> with MementoMixin {
  Counter() : super(0);

  back() => undo();

  Future<void> increment() async {
    setLoading(true);

    int value = state + 1;
    if (value <= 10) {
      update(value);
    } else {
      setError(Exception('Error: state not can be > 10'));
    }
    setLoading(false);
  }
}
