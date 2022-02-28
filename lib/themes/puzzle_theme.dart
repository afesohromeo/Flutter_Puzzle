import 'package:flutter/material.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PuzzleTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: PuzzleColors.black,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: PuzzleColors.black,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: PuzzleColors.black,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: PuzzleColors.black,
    ),
    headline4: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: PuzzleColors.grey1,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: PuzzleColors.blue50,
    ),
    headline5: GoogleFonts.openSans(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 195, 0, 255),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: PuzzleColors.white,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: PuzzleColors.white,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: PuzzleColors.white,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: PuzzleColors.white,
    ),
    headline4: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: PuzzleColors.grey2,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: PuzzleColors.green90,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      backgroundColor: PuzzleColors.white,
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //   selectedItemColor: Colors.green,
      // ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      backgroundColor: PuzzleColors.black2,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: PuzzleColors.bluePrimary,
      ),
      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //     selectedItemColor: PuzzleColors.yellow90),
      textTheme: darkTextTheme,
    );
  }
}
