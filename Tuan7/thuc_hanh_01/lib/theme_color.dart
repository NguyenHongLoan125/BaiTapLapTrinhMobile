import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveThemeColor(Color color) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('theme_color', color.value);
}

Future<Color> getSavedThemeColor() async {
  final prefs = await SharedPreferences.getInstance();
  int? colorValue = prefs.getInt('theme_color');
  return colorValue != null ? Color(colorValue) : Colors.blue;
}
