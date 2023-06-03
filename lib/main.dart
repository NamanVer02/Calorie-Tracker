import 'package:flutter/material.dart';
import 'package:calorie_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.greenAccent
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.greenAccent
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        // appBarTheme: const AppBarTheme().copyWith(
        //   backgroundColor: kDarkColorScheme.onPrimaryContainer,
        //   foregroundColor: kDarkColorScheme.onSecondary,
        // ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.surface,
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.onTertiaryContainer,
            foregroundColor: kDarkColorScheme.onPrimary,
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            color: kDarkColorScheme.onSecondary,
            fontSize: 28,
          ),
          titleMedium: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
          titleSmall: const TextStyle().copyWith(
            fontSize: 20,
          )
        ),
      ),

      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.onSecondary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.surface,
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.onTertiaryContainer,
            foregroundColor: kColorScheme.onPrimary,
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 28,
          ),
          titleMedium: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onPrimaryContainer,
            fontSize: 25,
          ),
        ),
      ),
      home: const Expenses()
    ),
  );
}
