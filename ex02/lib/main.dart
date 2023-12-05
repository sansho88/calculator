import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

import 'MyButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Design',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator Design'),
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

  var result = 0.0;
  var expression = "0";

  final List<String> buttons =[
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];


  void putButtonToExpression(String value){

  }

  void equalPressed(){
    String finishedExpression = expression;
    finishedExpression = expression.replaceAll('x', '*');

    Parser parser = Parser();
    Expression exp = parser.parse(finishedExpression);
    ContextModel contextModel = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, contextModel);
    result = eval;
  }


  void mytest(){

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          expression,
                          style: const TextStyle(fontSize: 16, color: Colors.amber),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "result.toStringAsFixed(10)",
                          style: const TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      )
                    ],
                  )
                ),
              ),
            Expanded(flex: 3,
                child: Container(
                  child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index){
                        if (index == 0) {
                          return MyButton(
                            numKey: () {
                              setState(() {
                                expression = '';
                                result = 0.0;
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.grey,
                            textColor: Colors.black,
                          );
                        } else if (index == 1) {
                          return MyButton(
                            buttonText: buttons[index],
                            color: Colors.grey,
                            textColor: Colors.black,
                          );
                        } else if (index == 2) {
                          return MyButton(
                            numKey: () {
                              setState(() {
                                expression += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.grey,
                            textColor: Colors.black,
                          );
                        } else if (index == 3) {
                          return MyButton(
                            numKey: () {
                              setState(() {
                                expression = expression.substring(0, expression.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.grey,
                            textColor: Colors.black,
                          );
                        } else if (index == 18) {
                          return MyButton(
                            numKey: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            buttonText: buttons[index],
                          );
                        } else {
                          return MyButton(
                            numKey: () {
                              setState(() {
                                expression += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                          );
                        }

                      })
                ))
          ],
      ),
    );
  }
}
