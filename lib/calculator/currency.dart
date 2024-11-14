import 'package:flutter/material.dart';
import 'package:croszma_apk/calculator/currconvert.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({super.key});

  @override
  _CurrencyCalculatorState createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);

  final CurrencyConverter converter = CurrencyConverter();
  Map<String, dynamic>? exchangeRates;
  String fromCurrency = 'USD';
  String toCurrency = 'EUR'; // Initial value
  double amount = 0;
  double convertedAmount = 0;

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  Future<void> _fetchExchangeRates() async {
    exchangeRates = await converter.fetchExchangeRates();
    // Convert all rates to doubles if they are strings
    exchangeRates = exchangeRates?.map((key, value) =>
        MapEntry(key, value is String ? double.tryParse(value) ?? 0 : value));

    // Set default value for toCurrency after exchange rates are available
    if (exchangeRates != null && exchangeRates!.isNotEmpty) {
      toCurrency = exchangeRates!.keys.first; // Set to first available currency
    }
    setState(() {});
  }

  void _convertCurrency() {
    if (exchangeRates != null) {
      double rate = exchangeRates![toCurrency];
      setState(() {
        convertedAmount = converter.convertCurrency(amount, rate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: darkBlue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(
                labelText: 'Amount in $fromCurrency',
                labelStyle: TextStyle(color: brightBlue),
                filled: true,
                fillColor: darkBlue,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: exchangeRates != null && exchangeRates!.isNotEmpty
                  ? toCurrency
                  : null, // Avoid error
              onChanged: (String? newValue) {
                setState(() {
                  toCurrency = newValue!;
                });
              },
              items: exchangeRates?.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: brightBlue)),
                );
              }).toList(),
              dropdownColor: darkBlue,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentBlue,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: const Text('Convert', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Amount: $convertedAmount $toCurrency',
              style: TextStyle(fontSize: 24, color: brightBlue),
            ),
          ],
        ),
      ),
    );
  }
}
