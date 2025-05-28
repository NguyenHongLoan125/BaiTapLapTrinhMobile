import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextDetail extends StatelessWidget {
  const TextDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.blue, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Text Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min, // để Column chỉ chiếm đúng nội dung, không bị kéo căng
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "The",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text("  "),
                  Text(
                    "quick",
                    style: TextStyle(
                      fontSize: 30,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                    ),
                  ),
                  Text("  "),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "B",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "rown",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.deepOrangeAccent,
                          )
                        )
                      ]
                    )
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "fox ",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "jumps",
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 5,
                    ),
                  ),
                  Text(
                    " over",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 95),
                child: Row(
                  children: [
                    Text(
                      "the ",
                      style: TextStyle(
                        fontSize: 30,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      "lazy",
                      style: GoogleFonts.pacifico(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      " dog.",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
