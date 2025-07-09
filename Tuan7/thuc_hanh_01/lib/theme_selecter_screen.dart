import 'package:flutter/material.dart';

class ThemeSelectorScreen extends StatefulWidget {
  final Color selectedColor;
  final Function(Color) onColorChanged;

  const ThemeSelectorScreen({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  State<ThemeSelectorScreen> createState() => _ThemeSelectorScreenState();
}

class _ThemeSelectorScreenState extends State<ThemeSelectorScreen> {
  late Color selectedColor;

  final List<Color> colorOptions = [
    Color(0xFF74B9FF), // Xanh dương
    Color(0xFFFD79A8), // Hồng
    Color(0xFFA29BFE), // Tím
    Color(0xFF2D3436), // Đen
  ];

  @override
  void initState() {
    super.initState();
    selectedColor = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Setting",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Choosing the right theme sets the tone and personality of your app",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: colorOptions.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedColor == color
                              ? Colors.black
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  widget.onColorChanged(selectedColor);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Theme color applied!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedColor,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child:
                const Text('Apply', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
