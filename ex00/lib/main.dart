import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'A Basic Display'),
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

  void sendDebugMsg() {
    debugPrint("Button pressed...bad boy :(");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'DON\'T PRESS THE BUTTON',
              style: TextStyle(height: 1, fontSize: 20),
            ),
            ElevatedButton(
                onPressed: sendDebugMsg,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.white12),
                    elevation: MaterialStatePropertyAll<double>(1.42)
                ),
                child: const Icon(Icons.adb)),
          ],
        ),
      ),
    );
  }
}
