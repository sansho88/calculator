import 'dart:ffi';

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
    '%',
    '00',
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
    '0',
    '.',
  ];

  MyButton getTouchedButton(int index, double aspectRatio){

    switch(buttons[index]){
      case "AC": return MyButton(numKey:(){
        setState(() {
          expression = '';
          result = 0.0;
          putButtonToDebug(buttons[index]);
        });
      }, buttonText: buttons[index], color: Colors.redAccent, textColor: Colors.black, aspectRatio: aspectRatio,);

      case "%":  return MyButton(numKey: (){
        setState(() {
          expression += buttons[index];
          putButtonToDebug(buttons[index]);
        });
      },buttonText: buttons[index], color: Colors.grey, textColor: Colors.black,aspectRatio: aspectRatio);

      case "C": return MyButton(numKey: (){
        setState(() {
          expression = expression.substring(0, expression.length - 1);
          putButtonToDebug(buttons[index]);
        });
      },buttonText: buttons[index], color: Colors.grey, textColor: Colors.black,aspectRatio: aspectRatio);

      case "=": return MyButton(numKey: (){
        setState(() {
          equalPressed();
          putButtonToDebug(buttons[index]);
        });
      },buttonText: buttons[index],aspectRatio: aspectRatio, color: Colors.orange,);
      default: return MyButton(numKey: (){
        setState(() {
          expression += buttons[index];
          putButtonToDebug(buttons[index]);
        });
      },buttonText: buttons[index],
        color: Colors.amberAccent,aspectRatio: aspectRatio
      );
    }
  }

  void putButtonToDebug(String value){
    debugPrint("Button: $value");
  }

  void equalPressed(){
    if (expression.isEmpty)
      return;
    String finishedExpression = expression;
    finishedExpression = expression.replaceAll('x', '*');

    try{
      Parser parser = Parser();
      Expression exp = parser.parse(finishedExpression);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      result = eval;
    }catch(e){
      if (e.runtimeType == RangeError)
        debugPrint("Something must follow the operator...");
      else
        debugPrint("You can\'t use it like that. Error: $e ");
      expression = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    const baseFontSize = 42.0;

    double dynamFontSize(){
    double fontSize = baseFontSize;
    final textPainter = TextPainter(
      text: TextSpan(text: expression, style: TextStyle(fontSize: fontSize)),
      textDirection: TextDirection.ltr,
    )..layout();

    while (textPainter.width > MediaQuery.of(context).size.width - 50 && fontSize > 20) {
      fontSize -= 1.0; // Réduire progressivement la taille de la police
      textPainter.text = TextSpan(text: expression, style: TextStyle(fontSize: fontSize));
      textPainter.layout();
    }

    return fontSize;
    }//(42 * (1 / (expression.length + 1).toDouble() * 2 + 0.5) + 20);

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:Column( mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[
            SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.topRight,
                      child: Text(
                        expression.isEmpty ? "0": expression,
                        style:  TextStyle(fontSize: dynamFontSize(), color: Colors.amber),
                        softWrap: true,
                        maxLines: MediaQuery.of(context).orientation == Orientation.portrait ? 6 : 2,

                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.topRight,
                      child: Text( result == 0 ? result.toStringAsPrecision(1) :
                      result.toStringAsFixed(10),
                        style: const TextStyle(fontSize: 42, color: Colors.green),
                      ),
                    )
                  ],
                ),
            )

              ,
            Expanded(flex: 2,
                child: Align(alignment: Alignment.bottomCenter,
                    child: GridView.builder(
                        itemCount: buttons.length
                        ,gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 2.9 * MediaQuery.of(context).size.aspectRatio),
                        itemBuilder: (BuildContext context, int index){
                          return AspectRatio(
                            aspectRatio: MediaQuery.of(context).orientation == Orientation.portrait ? 1.0 : 2.0,
                            child: getTouchedButton(index, MediaQuery.of(context).orientation == Orientation.portrait ? 1.0 : 2.0),
                          );

                        })),
                )
          ],
      ),
    );
  }
}
