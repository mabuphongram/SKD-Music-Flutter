import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:svrkxmdvm/pages/Home.dart';
import 'package:svrkxmdvm/pages/Register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Handle successful login here
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    } catch (e) {
      // Handle login failure here
      print('Login failed: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('* link ကိုနိမ့်ပြီးလျင် ဒီမှာ login ဝင်ပါ။ \n* ပြီးလျှင် သီချင်းများနားဆင်လို့ရပါပြီ'),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _signInWithEmailAndPassword,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Login'),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Don't have an account? "),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                },
                child: Text(" Register here!",style: TextStyle(color: Colors.blue),))
            ],)
          ],
        ),
      ),
    );
  }
}