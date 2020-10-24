import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    final TextTheme _textTheme = TextTheme(
      headline1: GoogleFonts.overpass(
          fontSize: 99, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      headline2: GoogleFonts.overpass(
          fontSize: 62, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      headline3:
          GoogleFonts.overpass(fontSize: 49, fontWeight: FontWeight.w400),
      headline4: GoogleFonts.overpass(
          fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline5:
          GoogleFonts.overpass(fontSize: 25, fontWeight: FontWeight.w400),
      headline6: GoogleFonts.overpass(
          fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subtitle1: GoogleFonts.overpass(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      subtitle2: GoogleFonts.overpass(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyText1: GoogleFonts.poppins(
          fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyText2: GoogleFonts.poppins(
          fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      button: GoogleFonts.poppins(
          fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      caption: GoogleFonts.poppins(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline: GoogleFonts.poppins(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    );

    return ThemeData(
      textTheme: _textTheme,
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Colors.white,
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
