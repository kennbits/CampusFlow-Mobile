import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth/login_screen.dart';

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
    final isDark =
        prefs.getBool('dark_mode') ?? false;

    setState(() {
      themeMode = isDark
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  Future<void> changeTheme(bool dark) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'dark_mode',
      dark,
    );

    setState(() {
      themeMode = dark
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusFlow',
      themeMode: themeMode,

      theme: _lightTheme(),

      darkTheme: _darkTheme(),

      home: const LoginScreen(),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme:
          const ColorScheme.light(
        primary: Color(0xFFED1B2F),
        secondary: Color(0xFF0088CB),
        surface: Colors.white,
      ),

      scaffoldBackgroundColor:
          const Color(0xFFF5F6FA),

      cardColor: Colors.white,

      fontFamily: 'Poppins',

      appBarTheme:
          const AppBarTheme(
        backgroundColor:
            Color(0xFFED1B2F),
        foregroundColor:
            Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      cardTheme:
          CardThemeData(
        color: Colors.white,
        elevation: 4,
        margin:
            const EdgeInsets.all(8),
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
                  22),
        ),
      ),

      elevatedButtonTheme:
          ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              const Color(
            0xFFED1B2F,
          ),
          foregroundColor:
              Colors.white,
          elevation: 2,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
                    16),
          ),
          textStyle:
              const TextStyle(
            fontSize: 16,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),

      outlinedButtonTheme:
          OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
          foregroundColor:
              const Color(
            0xFFED1B2F,
          ),
          side: const BorderSide(
            color:
                Color(0xFFED1B2F),
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
                    16),
          ),
        ),
      ),

      inputDecorationTheme:
          InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle:
            const TextStyle(
          color: Colors.black54,
        ),
        hintStyle:
            const TextStyle(
          color: Colors.black38,
        ),
        prefixIconColor:
            const Color(
          0xFFED1B2F,
        ),
        suffixIconColor:
            Colors.black45,
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                  16),
          borderSide:
              BorderSide.none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                  16),
          borderSide:
              BorderSide.none,
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                  16),
          borderSide:
              const BorderSide(
            color:
                Color(0xFFED1B2F),
            width: 1.5,
          ),
        ),
      ),

      snackBarTheme:
          const SnackBarThemeData(
        backgroundColor:
            Color(0xFFED1B2F),
        contentTextStyle:
            TextStyle(
          color: Colors.white,
        ),
        behavior:
            SnackBarBehavior.floating,
      ),

      dividerTheme:
          const DividerThemeData(
        color: Colors.black12,
        thickness: 1,
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme:
          const ColorScheme.dark(
        primary: Color(0xFFED1B2F),
        secondary: Color(0xFF0088CB),
        surface:
            Color(0xFF1E1E1E),
      ),

      scaffoldBackgroundColor:
          const Color(0xFF121212),

      cardColor:
          const Color(0xFF1E1E1E),

      fontFamily: 'Poppins',

      appBarTheme:
          const AppBarTheme(
        backgroundColor:
            Color(0xFF1A1A1A),
        foregroundColor:
            Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      cardTheme:
          CardThemeData(
        color:
            const Color(
          0xFF1E1E1E,
        ),
        elevation: 2,
        margin:
            const EdgeInsets.all(8),
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
                  22),
        ),
      ),

      elevatedButtonTheme:
          ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              const Color(
            0xFFED1B2F,
          ),
          foregroundColor:
              Colors.white,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
                    16),
          ),
          textStyle:
              const TextStyle(
            fontSize: 16,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),

      inputDecorationTheme:
          InputDecorationTheme(
        filled: true,
        fillColor:
            const Color(
          0xFF232323,
        ),
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle:
            const TextStyle(
          color: Colors.white70,
        ),
        hintStyle:
            const TextStyle(
          color: Colors.white38,
        ),
        prefixIconColor:
            const Color(
          0xFFED1B2F,
        ),
        suffixIconColor:
            Colors.white54,
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                  16),
          borderSide:
              BorderSide.none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                  16),
          borderSide:
              BorderSide.none,
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                  16),
          borderSide:
              const BorderSide(
            color:
                Color(0xFFED1B2F),
            width: 1.5,
          ),
        ),
      ),

      snackBarTheme:
          const SnackBarThemeData(
        backgroundColor:
            Color(0xFFED1B2F),
        behavior:
            SnackBarBehavior.floating,
      ),

      dividerTheme:
          const DividerThemeData(
        color: Colors.white12,
        thickness: 1,
      ),
    );
  }
}