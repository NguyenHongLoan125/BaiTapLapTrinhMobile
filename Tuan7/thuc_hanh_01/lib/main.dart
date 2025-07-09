import 'package:flutter/material.dart';
import 'package:thuc_hanh_01/theme_color.dart';
import 'package:thuc_hanh_01/theme_selecter_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeColor = await getSavedThemeColor();
  runApp(MyApp(initialColor: themeColor));
}

class MyApp extends StatefulWidget {
  final Color initialColor;
  const MyApp({super.key, required this.initialColor});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.initialColor;
  }

  void updateTheme(Color newColor) {
    setState(() {
      currentColor = newColor;
    });
    saveThemeColor(newColor); // Lưu lại màu mới
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Color App',
      theme: ThemeData(
        primarySwatch: createMaterialColor(currentColor),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: currentColor,
        scaffoldBackgroundColor: currentColor,
      ),
      themeMode: ThemeMode.system,
      home: ThemeSelectorScreen(
        selectedColor: currentColor,
        onColorChanged: updateTheme,
      ),
    );
  }
}

// Tạo MaterialColor từ Color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) strengths.add(0.1 * i);

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
