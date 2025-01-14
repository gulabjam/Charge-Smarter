import 'package:flutter/material.dart';
import 'package:sample_app/login.dart';
import 'register.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("evcharging.jpg"), fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Text('CHARGE SMARTER!',
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 150),
            Text("Find your nearest charging station",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center),
            SizedBox(height: 120),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 75, vertical: 25),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  side: const BorderSide(
                    color: Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                ),
              ).copyWith(
                // Define button appearance for different states
                overlayColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 91, 89, 89)), // Pressed state
                shadowColor: WidgetStateProperty.all(
                    Colors.black.withOpacity(0.5)), // Hover state
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(height: 35),
            Text(
              'Do not have an account yet?',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()));
                },
                child: Text('Register',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      decoration:
                          TextDecoration.underline, // Underline the text
                      decorationColor: Colors.blue,
                    )))
          ],
        ),
      ),
    );
  }
}