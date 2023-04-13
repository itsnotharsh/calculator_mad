import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _expression = '';
      } else if (buttonText == '=') {
        Parser p = Parser();
        Expression exp = p.parse(_expression);
        ContextModel cm = ContextModel();
        _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
      } else if (buttonText == 'DEL' && _expression != '') {
        dynamic x = _expression.length - 1;
        _expression = _expression.substring(0, x);
      } else if (buttonText == 'DEL' && _expression == '') {
        _expression = '';
      } else {
        _expression += buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[300],
          onPrimary: Colors.black,
          padding: const EdgeInsets.all(24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _expression,
                  style: TextStyle(fontSize: 48.0),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton('.'),
                _buildButton('0'),
                _buildButton('AC'),
                _buildButton('+'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildButton('('),
                _buildButton(')'),
                _buildButton('DEL'),
                _buildButton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
