import 'package:easy_localization/easy_localization.dart';
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

extension DateTimeExtension on DateTime?{
  String toDateTimeString(){
    if(this != null){
      DateFormat dateFormat = DateFormat("dd-MMM-yy HH:mm a");
      return dateFormat.format(this!) ;
    }else{
      return "";
    }
  }
  String toddMMMyyyy(){
    if(this != null){
      DateFormat dateFormat = DateFormat("dd MMM, yyyy");
      return dateFormat.format(this!) ;
    }else{
      return "";
    }
  }
  String tohhmma(){
    if(this != null){
      DateFormat dateFormat = DateFormat("hh:mm a");
      return dateFormat.format(this!) ;
    }else{
      return "";
    }
  }
  String toddMMMyyyyhhmma(){
    if(this != null){
      DateFormat dateFormat = DateFormat("dd MMM, yyyy hh:mm a");
      return dateFormat.format(this!) ;
    }else{
      return "";
    }
  }
}