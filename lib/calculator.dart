import 'package:flutter/material.dart';
import 'package:croszma_apk/calculator/currency.dart';
import 'package:croszma_apk/calculator/distance.dart';
import 'package:croszma_apk/calculator/general.dart';
import 'package:croszma_apk/calculator/percentage.dart';
import 'package:croszma_apk/calculator/temperature.dart';
import 'package:croszma_apk/calculator/time.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: darkBlue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildCalculatorCard('General', Icons.calculate, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GeneralCalculator()),
              );
            }),
            _buildCalculatorCard('Temperature', Icons.thermostat, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TempCalculator()),
              );
            }),
            _buildCalculatorCard('Currency', Icons.money, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CurrencyCalculator()),
              );
            }),
            _buildCalculatorCard('Time', Icons.timer, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimeCalculator()),
              );
            }),
            _buildCalculatorCard('Distance', Icons.social_distance, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DistanceCalculator()),
              );
            }),
            _buildCalculatorCard('Percentage', Icons.percent, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PercentCalculator()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              accentBlue.withOpacity(0.8),
              brightBlue.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: brightBlue.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
