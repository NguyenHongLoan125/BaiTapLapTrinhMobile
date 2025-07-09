import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
  const Confirm({
    super.key,
    required this.email,
    required this.code,
    required this.password,
  });

  final String email;
  final String code;
  final String password;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
    TextEditingController(text: email);
    final TextEditingController codeController =
    TextEditingController(text: code);
    final TextEditingController passwordController =
    TextEditingController(text: password);

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
            "Confirm",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "We are here to help you.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Input fields
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: "Email",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.confirmation_number),
                    border: OutlineInputBorder(),
                    hintText: "Verification Code",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    hintText: "New Password",
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: SizedBox(
              width: 400,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý logic xác nhận tại đây
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Submitted")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
                child: const Text(
                  "Submit",
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
