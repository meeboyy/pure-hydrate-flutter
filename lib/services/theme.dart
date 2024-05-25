import 'package:flutter/material.dart';

final ThemeData lightThemeCustom = ThemeData(
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //   backgroundColor: Color(0xFFCCE5FF),
  //   selectedItemColor: Color.fromARGB(255, 19, 123, 168),
  //   unselectedItemColor: Color.fromARGB(255, 127, 161, 175),
  //   type: BottomNavigationBarType.fixed,
  // ),
  primaryColor: const Color(0xff1976D2),
  cardColor: Color(0xFFcaf0f8),
  scaffoldBackgroundColor: Color(0xFFE3F2FD),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFCCE5FF),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Color.fromARGB(255, 19, 123, 168),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    splashColor: Color(0xFF64B5F6),
    focusColor: Color(0xFF64B5F6),
    hoverColor: const Color(0xFF1976D2),
    foregroundColor: Color.fromARGB(255, 39, 38, 38),
    backgroundColor: Color(0xFFcaf0f8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 8.0,
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
      color: Color.fromARGB(255, 104, 205, 248),
    ),
    foregroundColor: Color.fromARGB(255, 39, 38, 38),
    backgroundColor: Color(0xFFcaf0f8),
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        side: BorderSide(width: 18.0, color: Colors.black)),
  )),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontFamily: "Poppins"),
    bodyMedium: TextStyle(color: Colors.black, fontFamily: "Poppins"),
  ),
  buttonTheme: const ButtonThemeData(),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF87CEEB)),
);

final ThemeData darkThemeCustom = ThemeData(
  sliderTheme: SliderThemeData(
      inactiveTrackColor: Color(0xFF999999),
      activeTrackColor: Color(0xFF87CEEB)),
  listTileTheme: ListTileThemeData(textColor: Color(0xFF999999)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF333333),
    selectedItemColor: Color(0xFF87CEEB),
    unselectedItemColor: Color(0xFF999999),
    type: BottomNavigationBarType.fixed,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFF999999),
    ),
    foregroundColor: const Color(0xFF87CEEB),
    backgroundColor: const Color(0xFF333333),
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  )),
  primaryColor: Colors.white,
  scaffoldBackgroundColor: const Color(0xFF000000),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF333333),
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF87CEEB)),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
  ).apply(
    bodyColor: Color(0xFF87CEEB),
    displayColor: Color(0xFF87CEEB),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.primary,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.redAccent),
);
