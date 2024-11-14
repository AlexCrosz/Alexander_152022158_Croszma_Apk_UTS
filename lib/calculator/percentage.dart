import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PercentCalculator extends StatefulWidget {
  const PercentCalculator({super.key});

  @override
  _PercentCalculatorState createState() => _PercentCalculatorState();
}

class _PercentCalculatorState extends State<PercentCalculator>
    with SingleTickerProviderStateMixin {
  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  double originalPrice = 0;
  double discountPercentage = 0;
  double discountedPrice = 0;
  double savedAmount = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

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
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void calculateDiscount() {
    setState(() {
      originalPrice = double.tryParse(_priceController.text) ?? 0;
      discountPercentage = double.tryParse(_discountController.text) ?? 0;
      discountedPrice =
          originalPrice - (originalPrice * (discountPercentage / 100));
      savedAmount = originalPrice - discountedPrice;
    });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: const Text('Discount Calculator'),
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
                    Icon(Icons.calculate_outlined, color: brightBlue, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      'Kalkulator Diskon',
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
                  boxShadow: [
                    BoxShadow(
                      color: brightBlue.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: brightBlue),
                      decoration: InputDecoration(
                        labelText: 'Harga Asli (Rp)',
                        labelStyle: TextStyle(color: brightBlue),
                        prefixIcon:
                            Icon(Icons.monetization_on, color: brightBlue),
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
                    TextField(
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: brightBlue),
                      decoration: InputDecoration(
                        labelText: 'Persentase Diskon (%)',
                        labelStyle: TextStyle(color: brightBlue),
                        prefixIcon: Icon(Icons.percent, color: brightBlue),
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateDiscount,
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
                      ResultRow(
                        label: 'Harga Asli:',
                        value: formatCurrency.format(originalPrice),
                        icon: Icons.price_check,
                        color: brightBlue,
                      ),
                      const SizedBox(height: 10),
                      ResultRow(
                        label: 'Potongan:',
                        value: formatCurrency.format(savedAmount),
                        icon: Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 10),
                      ResultRow(
                        label: 'Harga Setelah Diskon:',
                        value: formatCurrency.format(discountedPrice),
                        icon: Icons.attach_money,
                        color: brightBlue,
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

class ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const ResultRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 18, color: color),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18, color: color),
        ),
      ],
    );
  }
}
