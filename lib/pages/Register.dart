import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:svrkxmdvm/pages/Home.dart';
import 'package:svrkxmdvm/pages/Login.dart';
import 'dart:async';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _registerWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    //load allowed accounts from users



    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Send email verification
    await userCredential.user!.sendEmailVerification();
     Timer(Duration(days: 1), () async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.delete();
        print('Unverified user deleted.');
      }
    });
      // Handle successful registration here
      if (userCredential.user!.emailVerified) {
      // Handle successful registration here
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      // show alert dialog box is here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration ပြီးမြောက်ရန်'),
          content: Text(
            'သင်၏ gmail ထဲသို့ verified link ပို့ပြီးပါပြီ။ ဝင်၍ link ကိုနိမ့်ပါ။',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
    
    } catch (e) {
      // Handle registration failure here
      print('Registration failed: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('* page မှ သီချင်းများ ဝယ်ယူပြီးလျင် ဒီမှာ register လုပ်ပါ။'),
            SizedBox(height: 20,),
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
              onPressed: _isLoading ? null : _registerWithEmailAndPassword,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Register'),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("You have already an account? "),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                },
                child: Text(" Login here!",style: TextStyle(color: Colors.blue),))
            ],)
          ],
        ),
      ),
    );
  }
}
