import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CampusFlowApp());
}

class CampusFlowApp extends StatefulWidget {
  const CampusFlowApp({super.key});

  static _CampusFlowAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_CampusFlowAppState>()!;

  @override
  State<CampusFlowApp> createState() => _CampusFlowAppState();
}

class _CampusFlowAppState extends State<CampusFlowApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool('dark_mode') ?? false;

    setState(() {
      themeMode =
          dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> changeTheme(bool dark) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('dark_mode', dark);

    setState(() {
      themeMode =
          dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:
            const Color(0xFF121212),
        cardColor:
            const Color(0xFF1E1E1E),
      ),

      home: const LoginScreen(),
    );
  }
}