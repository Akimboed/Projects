
import 'package:final_assingment2/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../home.dart';
import '../service/auth.dart';

// Entry point of the application
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();

  final passcontroller = TextEditingController();

  void login() async{
    final auth = Auth();
    try{
      await auth.signIn(emailcontroller.text, passcontroller.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }catch (e){
      showDialog(context: context, builder: (context)=>AlertDialog(title: Text(e.toString()),));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a title for the login page
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation for visual engagement
            SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  "https://lottie.host/c1343770-1c15-40f4-af4c-800cdc3cad10/zGMpg7650F.json"),
            ),
            SizedBox(
              height: 20,
            ),
            // Welcome message for the login page
            Text(
              "Welcome back! Login.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            // Email input field with custom underline colors
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(

                hintText: 'Email',
                labelText: 'Email',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.blue), // Change color here
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.indigo[900]!), // Change color here
                ),
                border: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.green), // Change color here
                ),
              ),
            ),
            SizedBox(height: 20),
            // Password input field with custom underline colors
            TextField(
              controller: passcontroller,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.blue), // Change color here
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.indigo[900]!), // Change color here
                ),
                border: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.green), // Change color here
                ),
              ),
            ),
            SizedBox(height: 20),
            // Login button to navigate to the home page
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Button to navigate to the register page
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Row(children: [
                Text(
                  'No account?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  '  Register Now!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
