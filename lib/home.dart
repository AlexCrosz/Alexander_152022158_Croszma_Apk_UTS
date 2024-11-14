import 'package:flutter/material.dart';
import 'package:croszma_apk/calculator.dart';
import 'package:croszma_apk/fitness.dart';
import 'package:croszma_apk/profile.dart';
import 'package:croszma_apk/settings.dart';
import 'package:croszma_apk/statistic.dart';
import 'dart:math' as math;
import 'package:croszma_apk/task.dart';

class ThemeConfig {
  final Color darkBackground;
  final Color darkAccent;
  final Color accentColor;
  final Color brightAccent;

  ThemeConfig({
    required this.darkBackground,
    required this.darkAccent,
    required this.accentColor,
    required this.brightAccent,
  });

  static final Map<String, ThemeConfig> themes = {
    'Default': ThemeConfig(
      darkBackground: Color(0xFF1A1A2E),
      darkAccent: Color(0xFF16213E),
      accentColor: Color(0xFF0F3460),
      brightAccent: Color(0xFF4E9AF1),
    ),
    'Ocean': ThemeConfig(
      darkBackground: Color(0xFF001B48),
      darkAccent: Color(0xFF002D6D),
      accentColor: Color(0xFF004494),
      brightAccent: Color(0xFF2E8BC0),
    ),
    'Sunset': ThemeConfig(
      darkBackground: Color(0xFF2B0000),
      darkAccent: Color(0xFF4A0404),
      accentColor: Color(0xFF6B0F1A),
      brightAccent: Color(0xFFFF4B5C),
    ),
    'Forest': ThemeConfig(
      darkBackground: Color(0xFF1B2819),
      darkAccent: Color(0xFF2C4A25),
      accentColor: Color(0xFF3E6B35),
      brightAccent: Color(0xFF7AB55C),
    ),
  };
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _floatingController;
  late AnimationController _bubbleController;
  String _selectedTheme = 'Default';
  int _selectedIndex = 0;
  late ThemeConfig _currentTheme;

  @override
  void initState() {
    super.initState();
    _currentTheme = ThemeConfig.themes[_selectedTheme]!;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();
  }

  void _updateTheme(String newTheme) {
    setState(() {
      _selectedTheme = newTheme;
      _currentTheme = ThemeConfig.themes[newTheme]!;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Pindah ke halaman sesuai dengan item yang diklik
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentTheme.darkBackground,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _floatingController.value * math.pi * 2,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          _currentTheme.brightAccent.withOpacity(0.2),
                          _currentTheme.darkAccent.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  stretch: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: _currentTheme.darkAccent,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    centerTitle: true,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Welcome, Chief!',
                          style: TextStyle(
                            color: _currentTheme.brightAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 3,
                          width: 40,
                          decoration: BoxDecoration(
                            color: _currentTheme.brightAccent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _currentTheme.darkAccent,
                                _currentTheme.accentColor,
                              ],
                            ),
                          ),
                        ),
                        ...List.generate(
                          5,
                          (index) => AnimatedBuilder(
                            animation: _bubbleController,
                            builder: (context, child) {
                              return Positioned(
                                right: 20.0 * (index + 1) +
                                    (math.sin(_bubbleController.value *
                                            math.pi *
                                            2) *
                                        10),
                                bottom: 60.0 * (index % 2 + 1) +
                                    (math.cos(_bubbleController.value *
                                            math.pi *
                                            2) *
                                        10),
                                child: Opacity(
                                  opacity: 0.2 +
                                      (math.sin(_bubbleController.value *
                                              math.pi) *
                                          0.1),
                                  child: Icon(
                                    Icons.bubble_chart,
                                    size: 50.0 * (index % 3 + 1),
                                    color: _currentTheme.brightAccent
                                        .withOpacity(0.3),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAnimatedCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.palette,
                                    color: _currentTheme.brightAccent,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Choose Your Theme',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _currentTheme.brightAccent,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _currentTheme.brightAccent
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedTheme,
                                    isExpanded: true,
                                    dropdownColor: _currentTheme.darkAccent,
                                    items: ThemeConfig.themes.keys
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        _updateTheme(newValue);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: [
                            _buildQuickActionCard(
                              'Task',
                              Icons.task,
                              Colors.blue,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskPage()),
                              ),
                            ),
                            _buildQuickActionCard(
                              'Statistics',
                              Icons.insert_chart,
                              Colors.purple,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StatisticPage()),
                              ),
                            ),
                            _buildQuickActionCard(
                              'Fitness & Health',
                              Icons.fitness_center,
                              Colors.green,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FitnessHealth()),
                              ),
                            ),
                            _buildQuickActionCard(
                              'Calculator',
                              Icons.calculate,
                              Colors.orange,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalculatorPage()),
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _currentTheme.brightAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildQuickActionCard(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: color.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCard({required Widget child}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, (1 - _controller.value) * 50),
          child: Opacity(
            opacity: _controller.value,
            child: child,
          ),
        );
      },
    );
  }
}
