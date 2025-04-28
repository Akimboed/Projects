//
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../home.dart';
import '../service/auth.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  // Function to handle user registration
  void register() async {
    final auth = Auth();
    try {
      await auth.signUp(emailcontroller.text, passcontroller.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  "https://lottie.host/5a03fd07-8ce1-4e85-9112-e466947f7dc3/cYUDYuO34Z.json"),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome! Please, Register!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo[900]!),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo[900]!),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passcontroller,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo[900]!),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo[900]!),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text('Register'),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                "Already have an account? Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

