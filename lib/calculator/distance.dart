import 'package:flutter/material.dart';

class DistanceCalculator extends StatefulWidget {
  const DistanceCalculator({super.key});

  @override
  _DistanceCalculatorState createState() => _DistanceCalculatorState();
}

class _DistanceCalculatorState extends State<DistanceCalculator> {
  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);

  final TextEditingController _distanceController = TextEditingController();
  String _fromUnit = 'Kilometer';
  String _toUnit = 'Meter';
  double _result = 0;

  final Map<String, double> _conversionFactors = {
    'Kilometer': 1000,
    'Meter': 1,
    'Centimeter': 0.01,
    'Millimeter': 0.001,
    'Mile': 1609.34,
    'Yard': 0.9144,
    'Foot': 0.3048,
    'Inch': 0.0254,
  };

  void _calculateDistance() {
    double? inputDistance = double.tryParse(_distanceController.text);
    if (inputDistance == null) return;

    double meterValue = inputDistance * _conversionFactors[_fromUnit]!;
    _result = meterValue / _conversionFactors[_toUnit]!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: const Text('Distance Calculator'),
        backgroundColor: darkBlue,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [darkBlue, accentBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: brightBlue.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.straighten, color: brightBlue, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      'Kalkulator Jarak',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _distanceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: brightBlue),
                      decoration: InputDecoration(
                        labelText: 'Masukkan Jarak',
                        labelStyle: TextStyle(color: brightBlue),
                        prefixIcon: Icon(Icons.edit, color: brightBlue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: brightBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: brightBlue, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _fromUnit,
                            items: _conversionFactors.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _fromUnit = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Dari',
                              labelStyle: TextStyle(color: brightBlue),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            dropdownColor: darkBlue,
                            style: TextStyle(color: brightBlue),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _toUnit,
                            items: _conversionFactors.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _toUnit = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Ke',
                              labelStyle: TextStyle(color: brightBlue),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            dropdownColor: darkBlue,
                            style: TextStyle(color: brightBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateDistance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentBlue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.calculate),
                    SizedBox(width: 10),
                    Text('Hitung', style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
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
                      style: TextStyle(fontSize: 24, color: brightBlue),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_distanceController.text} $_fromUnit = ${_result.toStringAsFixed(2)} $_toUnit',
                      style: TextStyle(fontSize: 20, color: brightBlue),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
