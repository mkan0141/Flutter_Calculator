import 'package:flutter/material.dart';
import 'syntacticAnalysis.dart';

class Calclator extends StatefulWidget {
  @override
  State createState() => new CalclatorState();
}

class CalclatorState extends State<Calclator> {
  String _output = "0";
  bool _is_result = true;
  SyntacticAnalysis sa = new SyntacticAnalysis();
  
  bool isOperand(String str){
    String opr = str[str.length - 1];
    print("opr => " + opr);
    if(opr == '+' || opr == '−' || opr == '÷' || opr == '×') return true;
    else return false;
  }

  void buttonPressed(String status){
    String  output = "";
    print("status: " + status);
    if(status == "AC"){
      output = "0";
    }else if(_is_result){
      if(status.codeUnitAt(0) ^ 0x30 <= 9){
        output = status;
        _is_result = false;
      }else return ;
    }else if(_output == "0"){
      output = status;
    }else if(isOperand(status)){
      if(isOperand(_output)) {output = _output.substring(0, _output.length - 1) + status; print("debug: " + output);}
      else output = _output + status; 
    } else if(status == '='){
      _is_result = true;
      sa.setExpression(_output);
      double result = sa.expression();
      if(result.toInt() - result == 0)
        output = result.toInt().toString();
      else
        output = result.toString();
    }else{
      output = _output + status;
    }
    setState(() {
      _output = output;
    });
    print(_output);
  }

  Widget _button(String _number, Color _color) {
    return MaterialButton(
      padding: const EdgeInsets.all(8.0),
      height: 100,
      child: Text(
        _number,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white
        ),
      ),
      color: _color,
      onPressed : () => buttonPressed(_number)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(
                height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 100.0,
              ),
              alignment: Alignment.bottomRight,
              color: Colors.black,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("AC", Colors.grey[300]), // using custom widget _button
                 _button("+/−", Colors.grey[300]),
                 _button("%", Colors.grey[300]),
                 _button("÷", Colors.lightBlueAccent[400]) 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("7", Colors.grey[800]), // using custom widget _button
                 _button("8", Colors.grey[800]),
                 _button("9", Colors.grey[800]),
                 _button("×", Colors.lightBlueAccent[400]) 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("4", Colors.grey[800]), // using custom widget _button
                 _button("5", Colors.grey[800]),
                 _button("6", Colors.grey[800]),
                 _button("−", Colors.lightBlueAccent[400]) 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("1", Colors.grey[800]), // using custom widget _button
                 _button("2", Colors.grey[800]),
                 _button("3", Colors.grey[800]),
                 _button("+", Colors.lightBlueAccent[400]) 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                 _button("0", Colors.grey[800]), // using custom widget _button
                 _button("00", Colors.grey[800]),
                 _button(".", Colors.grey[800]),
                 _button("=", Colors.lightBlueAccent[400]) 
              ],
            ),
          ],
        )
      ),
    );
  }
}

class _Button extends StatefulWidget {
  bool _isPush = false;
  String _number = '';

  _Button(String number){
    _number = number;
  }
  @override
  _ButtonState createState() => new _ButtonState();
}

class _ButtonState extends State<_Button>{
  @override
  build(BuildContext context){
    return  GestureDetector(
    onTap: (){
      print('neko');
      widget._isPush = true;
      print(widget._isPush);
    },
    onTapCancel: (){
      widget._isPush = false;
      print(widget._isPush);
    },
    child: MaterialButton(
    padding: const EdgeInsets.all(8.0),
    height: 100,
    child: Text(
      widget._number,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.black
      ),
    ),
    textColor: Colors.black,
    color: widget._isPush ? Colors.red : Colors.grey[100],
  ));;
  }
}