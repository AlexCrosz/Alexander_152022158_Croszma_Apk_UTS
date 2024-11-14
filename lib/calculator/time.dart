import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeCalculator extends StatefulWidget {
  const TimeCalculator({super.key});

  @override
  _TimeCalculatorState createState() => _TimeCalculatorState();
}

class _TimeCalculatorState extends State<TimeCalculator>
    with SingleTickerProviderStateMixin {
  final Color darkBackground = const Color(0xFF1A1A2E);
  final Color darkBlue = const Color(0xFF16213E);
  final Color accentBlue = const Color(0xFF0F3460);
  final Color brightBlue = const Color(0xFF4E9AF1);

  String selectedZone = 'WIB';
  DateTime selectedDateTime = DateTime.now();
  String convertedTime = '';
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

  void convertTime() {
    DateTime utcTime = selectedDateTime.toUtc();
    DateTime convertedTimeValue;

    switch (selectedZone) {
      case 'WIB':
        convertedTimeValue = utcTime.add(const Duration(hours: 7));
        break;
      case 'WITA':
        convertedTimeValue = utcTime.add(const Duration(hours: 8));
        break;
      case 'WIT':
        convertedTimeValue = utcTime.add(const Duration(hours: 9));
        break;
      case 'UTC':
      default:
        convertedTimeValue = utcTime;
        break;
    }

    setState(() {
      convertedTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(convertedTimeValue);
    });
    _controller.forward(from: 0);
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: brightBlue,
              onPrimary: Colors.white,
              surface: darkBlue,
              onSurface: brightBlue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                primary: brightBlue,
                onPrimary: Colors.white,
                surface: darkBlue,
                onSurface: brightBlue,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        title: const Text('Time Converter'),
        backgroundColor: darkBlue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
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
                    Icon(Icons.access_time, color: brightBlue, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      'Kalkulator Waktu',
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
                    Text(
                      'Pilih Zona Waktu',
                      style: TextStyle(color: brightBlue, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: accentBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        value: selectedZone,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedZone = newValue!;
                            convertedTime = '';
                          });
                        },
                        items: <String>['WIB', 'WITA', 'WIT', 'UTC']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        dropdownColor: accentBlue,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        underline: Container(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectDateTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentBlue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, color: brightBlue),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: convertTime,
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
                      Text(
                        'Hasil Konversi:',
                        style: TextStyle(fontSize: 18, color: brightBlue),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        convertedTime.isNotEmpty
                            ? convertedTime
                            : 'Belum ada hasil',
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
