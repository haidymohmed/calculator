import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  List<String> buttons = [
    'C' , 'Del' , '%' , '/',
    '9' , '8' , '7' , '*',
    '6' , '5' , '4' , '-',
    '3' , '2' , '1' , '+',
    '0' , '.' , 'Ans' , '=',
  ];
  String input = '' , output = '';
  double result = 0.0;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              input,
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              output,
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                              ),
                            ),
                          )
                      ),
                    ],
                  ),

                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4
                    ),
                    itemBuilder: (context , index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            if(buttons[index] == 'C'){
                              setState(() {
                                input  = '';
                                output = '' ;
                              });
                            }
                            else if(buttons[index] == '*' || buttons[index] == '/' || buttons[index] == '+' || buttons[index] == '-' || buttons[index] == '%'){
                              if(input.endsWith('/') || input.endsWith('*') || input.endsWith('+')|| input.endsWith('-') || input.endsWith('%')){
                                null ;
                              }
                              else {
                                setState(() {
                                  input += buttons[index];
                                });
                              }
                            }
                            else if(buttons[index]  == 'Del'){
                              setState(() {
                                input = input.substring(0 , input.length -1);
                              });
                            }
                            else if(buttons[index] == '='){
                              Expression exp = Parser().parse(input);
                              result = exp.evaluate(EvaluationType.REAL, ContextModel());
                              setState(() {
                                output = result.toStringAsFixed(4);
                              });
                            }
                            else if(buttons[index] == 'Ans'){
                              setState(() {
                                input = result.toStringAsFixed(4);
                                output = '';
                              });
                            }
                            else {
                              setState(() {
                                input = input + buttons[index];
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: buttonColor(buttons[index]),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                                child: Text(
                                  buttons[index],
                                  style: TextStyle(
                                    color : textColor(buttons[index]),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,

                                  ),
                                )
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Color buttonColor(String c){
    if( c == 'C'){
      return Colors.green ;
    }
    else if (c == 'Del'){
      return Colors.red ;
    }
    else if(c == '%' || c == '+' || c == '/' || c == '-' || c == '=' || c == '*'){
      return Colors.blue ;
    }
    else{
      return Colors.grey;
    }
  }
  Color textColor(String c){
    if(c == '%' || c == '+' || c == '/' || c == '-' || c == '=' || c == '*' || c == 'Del' || c == 'C'){
      return Colors.white ;
    }
    else{
      return Colors.black;
    }
  }

}
