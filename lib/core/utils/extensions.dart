import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize(){
    if(isEmpty) return  "";
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DarkMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}