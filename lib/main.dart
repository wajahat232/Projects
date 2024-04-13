import 'package:calculator/colors.dart';
import 'package:calculator/splashscreen.dart';
import 'package:flutter/material.dart';
import'package:math_expressions/math_expressions.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}
class Calculator extends StatefulWidget {
  @override
  calculatorState createState() => calculatorState();
}
class calculatorState extends State<Calculator>{

  double firstnum = 0.0;
  double secondnum = 0.0;
  var input ='';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 40.0;

  onClickButton(value){
   if (value == 'AC'){
     input = '';
     output = '';
   }
   else if (value == '<--') {
     if (input.isNotEmpty) {
       input = input.substring(0, input.length - 1);
     }
   }
   else if (value == '=') {
     if (input.isNotEmpty) {
       var userInput = input;
       userInput= input.replaceAll('x', '*');
       Parser p = Parser();
       Expression expression = p.parse(userInput);
       ContextModel cm =ContextModel();
       var finalValue = expression.evaluate(EvaluationType.REAL, cm);
       output = finalValue.toString();
       if(output.endsWith('.0')){
         output = output.substring(0 , output.length-2);
       }
       input = output;
       hideInput = true;
       outputSize = 52;
     }
   }
   else {
       input = input + value;
       outputSize = 40;
       hideInput = false;

   }

    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: Colors.black,
      body: Column(
            children: [



              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      color: Colors.black,
                      width: double.infinity,

                      child:  Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Text(
                              hideInput? ''
                              :input ,
                              style: const TextStyle(fontSize: 50, color: Colors.white),),
                            SizedBox(height: 10,),
                            Text(output ,
                              style: TextStyle(fontSize: outputSize, color: Colors.white.withOpacity(0.7)),),
                            SizedBox(height: 30,),

                            Container(
                              width: double.infinity,
                              height: 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7)
                              ),
                            )
                          ],
                        ),

                    ),
                  )
              ),




              Row(
                children: [
                  button(text: 'AC' , buttonBgcolor: const Color(0xff727272), tcolor: Colors.orange),
                  button(text: '<--', buttonBgcolor: Color(0xff727272)),
                  button(text: '%',buttonBgcolor: Color(0xff727272)),
                  button(text: '/' , buttonBgcolor: Colors.orange),

                ],
              ),
              Row(
                children: [
                  button(text: '7'),
                  button(text: '8'),
                  button(text: '9'),
                  button(text: 'x' , buttonBgcolor: Colors.orange),

                ],
              ),
              Row(
                children: [
                  button(text: '4'),
                  button(text: '5'),
                  button(text: '6'),
                  button(text: '-',buttonBgcolor: Colors.orange)

                ],
              ),
              Row(
                children: [
                  button(text: '1'),
                  button(text: '2'),
                  button(text: '3'),
                  button(text: '+' , buttonBgcolor: Colors.orange),

                ],
              ),
              Row(
                children: [
                  SizedBox(width: 200,
                   child: button(text: '0'),),

                  button(text: '.'),
                  button(text: '=',buttonBgcolor: Colors.orange),
                ],
              ),

            ],
          ),

    );
  }

  Widget button({
    text, tcolor = Colors.white , buttonBgcolor = operatorcolor
}){
    return Expanded(child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: (){
            return onClickButton(text);
          },
          child: Text(text ,
            style: TextStyle(color: tcolor ,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:BorderRadius.all(Radius.circular(40))

            )),

            backgroundColor: MaterialStateProperty.all(buttonBgcolor),
            padding: MaterialStateProperty.all(EdgeInsets.all(22)),


          ),
        )
    )
    );
  }
}
