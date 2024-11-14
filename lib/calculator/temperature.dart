import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TempCalculator extends StatefulWidget {
  const TempCalculator({super.key});

  @override
  _TempCalculatorState createState() => _TempCalculatorState();
}

class _TempCalculatorState extends State<TempCalculator>
    with SingleTickerProviderStateMixin {
  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);

  double temperature = 0;
  String selectedUnit = 'Celsius';
  String convertedValue = '';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void convertTemperature() {
    if (selectedUnit == 'Celsius') {
      double fahrenheit = (temperature * 9 / 5) + 32;
      convertedValue = '${fahrenheit.toStringAsFixed(2)} °F';
    } else {
      double celsius = (temperature - 32) * 5 / 9;
      convertedValue = '${celsius.toStringAsFixed(2)} °C';
    }
    setState(() {});
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: darkBlue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'Kalkulator Suhu',
                style: TextStyle(
                  fontSize: 32,
                  color: brightBlue,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: brightBlue.withOpacity(0.5),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: brightBlue.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    temperature = double.tryParse(value) ?? 0;
                  },
                  decoration: InputDecoration(
                    labelText: 'Masukkan Suhu',
                    labelStyle: TextStyle(color: brightBlue),
                    filled: true,
                    fillColor: darkBlue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.thermostat, color: brightBlue),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: brightBlue),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  value: selectedUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedUnit = newValue!;
                      convertedValue = '';
                    });
                  },
                  items: <String>['Celsius', 'Fahrenheit']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: brightBlue)),
                    );
                  }).toList(),
                  dropdownColor: darkBlue,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down, color: brightBlue),
                  underline: Container(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: convertTemperature,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentBlue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Konversi', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 30),
              ScaleTransition(
                scale: _animation,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: brightBlue.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Hasil Konversi:',
                        style: TextStyle(fontSize: 18, color: brightBlue),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        convertedValue,
                        style: TextStyle(
                          fontSize: 32,
                          color: brightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
