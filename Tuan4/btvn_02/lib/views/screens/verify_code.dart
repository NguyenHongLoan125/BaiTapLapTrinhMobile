import 'package:flutter/material.dart';
import 'create_new_pasword.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> codeControllers = List.generate(
      6,
          (_) => TextEditingController(),
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          Image.asset('assets/img.png', height: 100),
          const Text(
            "SmartTasks",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Verify Code",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Enter the code we just sent you on your registered Email",
            textAlign: TextAlign.center,
          ),
          Text("Verification code sent to: $email"),
          const SizedBox(height: 20),

          // Code input
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 40,
                child: TextField(
                  controller: codeControllers[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  decoration: const InputDecoration(counterText: ""),
                ),
              );
            }),
          ),

          const SizedBox(height: 30),

          // Next button
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: SizedBox(
              width: 400,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final code = codeControllers.map((e) => e.text).join();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNewPassword(
                        email: email,
                        code: code,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
