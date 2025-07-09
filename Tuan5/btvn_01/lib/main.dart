import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


import 'profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTH SmartTasks',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        await FirebaseAnalytics.instance.logEvent(
          name: 'login_success',
          parameters: {
            'method': 'google',
            'user_id': user.uid,
            'email': user.email,
          },
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
        );
      }
    } catch (e) {
      print("Đăng nhập thất bại: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/uth.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
              ),
              const SizedBox(height: 20),
              const Text("UTH SmartTasks", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
              const Text("A simple and efficient to-do app", style: TextStyle(fontSize: 15, color: Colors.blue)),
              const SizedBox(height: 150),
              const Text("Welcome", style: TextStyle(fontSize: 20, )),
              const Text("Ready to explore? Log in to get started.", style: TextStyle(fontSize: 15, )),


              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () => signInWithGoogle(context),
                icon: Image.asset(
                  'assets/google.png',
                  height: 24,
                  width: 24,
                ),
                label: const Text("SIGN IN WITH GOOGLE", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),),
              )

            ]
        ),
      ),
    );
  }
}
