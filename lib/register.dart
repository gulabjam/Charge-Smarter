import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_app/Homepage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController email;
  late final TextEditingController pwd;
  @override
  void initState() {
    email = TextEditingController();
    pwd = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your E-mail here',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 10)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: pwd,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              hintText: 'Enter your password here',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 10)),
            ),
          ),
          TextButton(
            onPressed: () async {
              await Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              );
              final _email = email.text;
              final password = pwd.text;
              final usercredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _email, password: password);
              print(usercredential);
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()));
            },
            child: Text(
              'Register',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}