import 'package:flutter/material.dart';
import 'dart:math';

class GeneralCalculator extends StatefulWidget {
  const GeneralCalculator({super.key});

  @override
  _GenaralCalculatorState createState() => _GenaralCalculatorState();
}

class _GenaralCalculatorState extends State<GeneralCalculator> {
  String _output = "0";
  double _firstNumber = 0;
  String _operation = "";
  bool _isNewNumber = true;

  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _firstNumber = 0;
        _operation = "";
        _isNewNumber = true;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        _firstNumber = double.parse(_output);
        _operation = buttonText;
        _isNewNumber = true;
      } else if (buttonText == "=") {
        double secondNumber = double.parse(_output);
        if (_operation == "+") {
          _output = (_firstNumber + secondNumber).toString();
        }
        if (_operation == "-") {
          _output = (_firstNumber - secondNumber).toString();
        }
        if (_operation == "x") {
          _output = (_firstNumber * secondNumber).toString();
        }
        if (_operation == "÷") {
          _output = (_firstNumber / secondNumber).toString();
        }
        _firstNumber = 0;
        _operation = "";
        _isNewNumber = true;
      } else if (buttonText == "√") {
        double number = double.parse(_output);
        _output = sqrt(number).toString();
        _isNewNumber = true;
      } else if (buttonText == "x²") {
        double number = double.parse(_output);
        _output = pow(number, 2).toString();
        _isNewNumber = true;
      } else {
        if (_isNewNumber) {
          _output = buttonText;
          _isNewNumber = false;
        } else {
          _output = _output + buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color}) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? darkBlue,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: const Text('General Calculator'),
        backgroundColor: darkBlue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 48,
                color: brightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 2, color: Colors.grey),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("÷", color: accentBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("x", color: accentBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-", color: accentBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("0"),
                      _buildButton("."),
                      _buildButton("C", color: Colors.red),
                      _buildButton("+", color: accentBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("√", color: accentBlue),
                      _buildButton("x²", color: accentBlue),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brightBlue,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () => _buttonPressed("="),
                            child: const Text(
                              "=",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
