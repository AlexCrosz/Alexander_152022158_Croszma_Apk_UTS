import 'package:flutter/material.dart';
import 'dart:math';

class FitnessHealth extends StatefulWidget {
  const FitnessHealth({super.key});

  @override
  _FitnessHealthState createState() => _FitnessHealthState();
}

class _FitnessHealthState extends State<FitnessHealth> {
  final _formKey = GlobalKey<FormState>();
  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);
  double height = 0;
  double weight = 0;
  int age = 0;
  String gender = 'male';
  String activityLevel = 'sedentary';
  double bmi = 0;
  double calories = 0;

  void _calculateFitness() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Calculate BMI
        bmi = weight / pow(height / 100, 2);

        // Calculate BMR using Harris-Benedict equation
        double bmr;
        if (gender == 'male') {
          bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
        } else {
          bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
        }

        // Calculate daily calories based on activity level
        switch (activityLevel) {
          case 'sedentary':
            calories = bmr * 1.2;
            break;
          case 'light':
            calories = bmr * 1.375;
            break;
          case 'moderate':
            calories = bmr * 1.55;
            break;
          case 'active':
            calories = bmr * 1.725;
            break;
          case 'very_active':
            calories = bmr * 1.9;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Fitness Calculator',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                _buildCard(
                  child: Column(
                    children: [
                      _buildTextField(
                        label: 'Height (cm)',
                        onChanged: (value) =>
                            height = double.tryParse(value) ?? 0,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Weight (kg)',
                        onChanged: (value) =>
                            weight = double.tryParse(value) ?? 0,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Age',
                        onChanged: (value) => age = int.tryParse(value) ?? 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Male'),
                              value: 'male',
                              groupValue: gender,
                              onChanged: (value) =>
                                  setState(() => gender = value.toString()),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text('Female'),
                              value: 'female',
                              groupValue: gender,
                              onChanged: (value) =>
                                  setState(() => gender = value.toString()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Activity Level',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButtonFormField<String>(
                        value: activityLevel,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'sedentary',
                              child: Text('Sedentary (little or no exercise)')),
                          DropdownMenuItem(
                              value: 'light',
                              child: Text('Light (exercise 1-3 times/week)')),
                          DropdownMenuItem(
                              value: 'moderate',
                              child:
                                  Text('Moderate (exercise 4-5 times/week)')),
                          DropdownMenuItem(
                              value: 'active',
                              child: Text('Active (daily exercise)')),
                          DropdownMenuItem(
                              value: 'very_active',
                              child: Text('Very Active (intense exercise)')),
                        ],
                        onChanged: (value) =>
                            setState(() => activityLevel = value!),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _calculateFitness,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 24),
                if (bmi > 0) ...[
                  _buildResultCard(
                    title: 'BMI Result',
                    value: bmi.toStringAsFixed(1),
                    subtitle: _getBMICategory(bmi),
                  ),
                  const SizedBox(height: 16),
                  _buildResultCard(
                    title: 'Daily Calories Needed',
                    value: '${calories.toStringAsFixed(0)} kcal',
                    subtitle: 'Based on your activity level',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: accentBlue,
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Widget _buildResultCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentBlue, brightBlue.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: brightBlue.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Normal weight';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}
