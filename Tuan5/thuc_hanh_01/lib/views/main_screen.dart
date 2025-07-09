import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

enum LoginStatus { none, success, error }

class _MainScreenState extends State<MainScreen> {
  String? userEmail;
  String? errorMessage;
  LoginStatus status = LoginStatus.none;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the login
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập với Firebase bằng token từ Google
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Ghi thông tin người dùng vào Realtime Database
      final user = userCredential.user;
      if (user != null) {
        // final databaseRef = FirebaseDatabase.instance.ref();
        // await databaseRef.child("users").child(user.uid).set({
        //   "email": user.email,
        //   "displayName": user.displayName,
        //   "photoURL": user.photoURL,
        //   "uid": user.uid,
        //   "loginTime": DateTime.now().toIso8601String(),
        // });
        await FirebaseAnalytics.instance.logEvent(
          name: 'login_success',
          parameters: {
            'method': 'google',
            'user_id': user.uid,
            'email': user.email,
          },
        );

        setState(() {
          userEmail = user.email;
          status = LoginStatus.success;
        });
      }
    } catch (e) {
      setState(() {
        status = LoginStatus.error;
        errorMessage = 'Google Sign-In Failed: $e';
      });
    }
  }




  Widget _buildStatusBox() {
    switch (status) {
      case LoginStatus.success:
        return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text('Success!', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Hi $userEmail'),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Welcome to '),
                    TextSpan(
                        text: 'UTHSmartTasks',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );

      case LoginStatus.error:
        return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text('Sign-In Failed', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(errorMessage ?? 'Unknown error'),
            ],
          ),
        );

      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: signInWithGoogle,
              child: Text("Login with Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: StadiumBorder(),
              ),
            ),
            _buildStatusBox(),
          ],
        ),
      ),
    );
  }
}
