import 'package:flutter/material.dart';

const ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary:   Colors.deepPurple, //
  onPrimary: Colors.white,
  secondary: Color(0xFF3498DB), // Blue
  onSecondary: Colors.black,
  error: Color(0xFFE74C3C), // Red
  onError: Colors.white,
  background: Color(0xFFFFFFFF), // White
  onBackground: Color(0xFF2C3E50), // Dark Gray
  surface: Color(0xFFECF0F1), // Light Blue
  onSurface: Color(0xFF2C3E50), // Dark Gray
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: colorScheme.primary,
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.background,
  canvasColor: colorScheme.surface,
  cardColor: Colors.white,
  dividerColor: const Color(0xFFBDC3C7),
  focusColor: const Color(0xFF2ECC71), // Green
  hoverColor: const Color(0xFFE74C3C), // Red
  splashColor: const Color(0xFFE74C3C).withOpacity(0.3),
  highlightColor: const Color(0xFFE74C3C).withOpacity(0.2),
  disabledColor: const Color(0xFFBDC3C7),
  hintColor: const Color(0xFF7F8C8D),

  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: colorScheme.onBackground,
    ),
    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: colorScheme.onBackground,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      color: colorScheme.onBackground,
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      fontFamily: 'OpenSans',
      color: colorScheme.onSurface,
    ),
  ),
  iconTheme: IconThemeData(
    color: colorScheme.onSurface,
    size: 24.0,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF1ABC9C), // Teal
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    // elevation: 4,
    titleTextStyle: TextStyle(
      color: colorScheme.primary,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: colorScheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF7F7F7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFBDC3C7)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.primary),
      borderRadius: BorderRadius.circular(8.0),
    ),
    hintStyle: const TextStyle(color: Color(0xFFBDC3C7)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorScheme.primary,
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: colorScheme.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: colorScheme.primary,
    unselectedItemColor: const Color(0xFFBDC3C7),
    elevation: 8,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: colorScheme.primary,
    inactiveTrackColor: const Color(0xFFBDC3C7),
    thumbColor: colorScheme.primary,
    overlayColor: colorScheme.primary.withOpacity(0.3),
    valueIndicatorColor: colorScheme.primary,
    valueIndicatorTextStyle: const TextStyle(color: Colors.white),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: colorScheme.primary,
    unselectedLabelColor: const Color(0xFFBDC3C7),
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: colorScheme.primary,
    contentTextStyle: const TextStyle(color: Colors.white),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all<Color>(Colors.white),
    fillColor: MaterialStateProperty.all<Color>(colorScheme.primary),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all<Color>(colorScheme.primary),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(colorScheme.primary),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
);
