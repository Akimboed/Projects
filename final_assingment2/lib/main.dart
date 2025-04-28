import 'package:final_assingment2/screens/login.dart';
import 'package:final_assingment2/screens/register.dart';
import 'package:final_assingment2/screens/settings.dart';
import 'package:final_assingment2/themes/darkTheme.dart';
import 'package:final_assingment2/themes/lightTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // Import your login page
import 'home.dart'; // Import your home page
import 'service/auth.dart'; // Import the Auth class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: AuthCheck(), // Use AuthCheck to determine the initial screen
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/settings': (context) => Settings(),
        '/home': (context) => Home(), // Add your Home page route
      },
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Auth();

    // Use FutureBuilder to check if the user is logged in
    return FutureBuilder<User?>(
      future: Future.value(authService.getCurrentUser()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the auth state
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          // If the user is logged in, navigate to Home
          return Home();
        } else {
          // If the user is not logged in, navigate to Login
          return RegisterPage();
        }
      },
    );
  }
}
