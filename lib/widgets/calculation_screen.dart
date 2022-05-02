import 'package:flutter/material.dart';
import 'package:flutter_calculation/constants/constants.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculationScreen extends StatefulWidget {
  CalculationScreen({Key? key}) : super(key: key);

  @override
  State<CalculationScreen> createState() => _CalculationScreen();
}

class _CalculationScreen extends State<CalculationScreen> {
  var userInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppbar(),
      backgroundColor: Colors.white,
      body: _getMainBody(),
    );
  }

  //---------------------functions
  PreferredSizeWidget _getAppbar() {
    return AppBar(
      title: Text('Calculator'),
      backgroundColor: backgroundGreyDark,
      elevation: 1,
    );
  }

  Widget _getMainBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 60,
              color: backgroundGreyDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 12.0, bottom: 22.0, top: 100.0),
                    child: Text(
                      userInput,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 28,
                        color: textGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              height: 120,
              color: backgroundGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getRow('ac', 'ce', '%', '/'),
                  _getRow('7', '8', '9', '*'),
                  _getRow('4', '5', '6', '-'),
                  _getRow('1', '2', '3', '+'),
                  _getRow('00', '0', '.', '='),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getRow(String s1, String s2, String s3, String s4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _getTextButton(s1),
        _getTextButton(s2),
        _getTextButton(s3),
        _getTextButton(s4),
      ],
    );
  }

  Widget _getTextButton(String string) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(width: 0, color: Colors.transparent),
        ),
        backgroundColor: _getBackgroundColor(string),
      ),
      onPressed: () {
        if (string == 'ac') {
          setState(() {
            userInput = '';
          });
        } else if (string == 'ce') {
          setState(() {
            if (userInput.length > 0) {
              userInput = userInput.substring(0, userInput.length - 1);
            }
          });
        } else if (string == '=') {
          Parser parser = Parser();
          Expression expression = parser.parse(userInput);
          ContextModel contextModel = ContextModel();
          double evaluationResult =
              expression.evaluate(EvaluationType.REAL, contextModel);
          setState(() {
            userInput = evaluationResult.toString();
          });
        } else {
          _buttonPressed(string);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Text(
          '$string',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            color: _getTextColor(string),
          ),
        ),
      ),
    );
  }

  bool _isOperator(String string) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var currentItem in list) {
      if (string == currentItem) {
        return true;
      }
    }
    return false;
  }

  Color _getBackgroundColor(String string) {
    if (_isOperator(string)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color _getTextColor(String string) {
    if (_isOperator(string)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }

  void _buttonPressed(String string) {
    setState(() {
      userInput = userInput + string;
    });
  }
}
