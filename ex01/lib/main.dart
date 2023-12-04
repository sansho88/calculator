import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Say Hello World on Click'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var messages = ["Ahum...", "Hello World!"];
  var msgSelector = 0;

  void changeMsg() {
    setState(() {
     ++msgSelector;
     msgSelector %= messages.length;
     debugPrint("result: ${msgSelector % messages.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("MsgSelector=$msgSelector");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              messages[msgSelector],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FloatingActionButton(
              onPressed: changeMsg,
              tooltip: 'Say Hello World!',
              child: const Icon(Icons.account_balance),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
