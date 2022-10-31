import 'package:auth_learn/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool ishiddenpassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  registerSubmit() async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: _emailController.text.toString().trim(),
            password: _passwordController.text,
          )
          .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen())));
    } catch (e) {
      print(e);
      SnackBar(content: Text(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  "TUGAS AKHIR APPS",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Image.asset('image/logo.png', width: 200, height: 200),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Username'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _passwordController,
                  obscureText: ishiddenpassword,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: togglePassword, child: Icon(Icons.visibility)),
                      border: OutlineInputBorder(),
                      labelText: 'Password'),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  fixedSize: Size(307, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Register', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  registerSubmit();
                },
              ),
            ],
          )),
    );
  }

  void togglePassword() {
    setState(() {
      ishiddenpassword = !ishiddenpassword;
    });
  }
}
