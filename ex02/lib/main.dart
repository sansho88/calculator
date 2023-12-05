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
  var expression = "";

  final List<String> buttons =[
    'AC',
    'C',
    '+/-',
    '%',
    '=',
    '7',
    '8',
    '9',
    'x',
    '/',
    '4',
    '5',
    '6',
    '+',
    '-',
    '1',
    '2',
    '3',
    '.',
    '00',
    '0',
  ];


  void putButtonToDebug(String value){
    debugPrint("Button: $value");
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
                          expression.isEmpty ? "0": expression,
                          style: const TextStyle(fontSize: 42, color: Colors.amber),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text( result == 0 ? result.toStringAsPrecision(1) :
                        result.toStringAsFixed(10),
                          style: const TextStyle(fontSize: 42, color: Colors.green),
                        ),
                      )
                    ],
                  )
                ),
              ),
            Expanded(flex: 1,
                child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length
                      ,gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                      itemBuilder: (BuildContext context, int index){
                        switch(buttons[index]){
                          case "AC": return MyButton(numKey:(){
                            setState(() {
                              expression = '';
                              result = 0.0;
                              putButtonToDebug(buttons[index]);
                            });
                          }, buttonText: buttons[index], color: Colors.grey, textColor: Colors.black,);
                          case "+/-":  return MyButton(numKey: (){
                            putButtonToDebug(buttons[index]);
                            expression = expression[0] == '-' ? expression.substring(1): '-$expression';
                          },
                            buttonText: buttons[index], color: Colors.grey, textColor: Colors.black,);

                          case "%":  return MyButton(numKey: (){
                            setState(() {
                              expression += buttons[index];
                              putButtonToDebug(buttons[index]);
                            });
                          },buttonText: buttons[index], color: Colors.grey, textColor: Colors.black,);

                          case "C": return MyButton(numKey: (){
                            setState(() {
                              expression = expression.substring(0, expression.length - 1);
                              putButtonToDebug(buttons[index]);
                            });
                          },buttonText: buttons[index], color: Colors.grey, textColor: Colors.black,);

                          case "=": return MyButton(numKey: (){
                            setState(() {
                              equalPressed();
                              putButtonToDebug(buttons[index]);
                            });
                          },buttonText: buttons[index]);
                          default: return MyButton(numKey: (){
                            setState(() {
                              expression += buttons[index];
                              putButtonToDebug(buttons[index]);
                            });
                          },buttonText: buttons[index],
                            color: Colors.greenAccent,);
                        }
                      })
                ))
          ],
      ),
    );
  }
}
