import 'package:flutter/material.dart';

class TextfieldDetail extends StatefulWidget {
  const TextfieldDetail({super.key});

  @override
  State<TextfieldDetail> createState() => _TextfieldDetailState();
}

class _TextfieldDetailState extends State<TextfieldDetail> {
  final TextEditingController _controller = TextEditingController();
  String _text = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _text = _controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TextField",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.blue, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 180),
              child: Container(
                width: 300,
                child: TextField(
                  controller: _controller, // <- thêm dòng này
                  decoration: InputDecoration(
                      hintText: "Thông tin nhập",
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(15),
                          )
                      )
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _text.isNotEmpty
              ? Text(
            " $_text",
            style: TextStyle(fontSize: 16),
          )
              : Text(
            "Tự động cập nhật dữ liệu theo textfield",
            style: TextStyle(
              color: Colors.red,
            ),
          ),

        ],
      ),
    );
  }
}
