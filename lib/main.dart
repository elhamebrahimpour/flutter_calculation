import 'package:flutter/material.dart';
import 'package:flutter_calculation/widgets/calculation_screen.dart';

void main() {
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatelessWidget {
  const CalculatorApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculationScreen(),
    );
  }
}
