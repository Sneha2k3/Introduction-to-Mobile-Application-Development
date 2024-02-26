import 'package:flutter/material.dart';
import 'dart:async';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  bool _isButtonDisabled = false;
  int _cooldownRemaining = 0;
  late Timer _cooldownTimer;

  void _startCooldown() {
    setState(() {
      _isButtonDisabled = true;
      _cooldownRemaining = 30;
    });

    _cooldownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_cooldownRemaining > 0) {
          _cooldownRemaining--;
        } else {
          _isButtonDisabled = false;
          _cooldownTimer.cancel();
        }
      });
    });

    // Implement your logic to send a reset link here
    String email = _emailController.text;

    // For demonstration purposes, let's just print the email
    print('Reset link sent to: $email');
  }

  @override
  void dispose() {
    _cooldownTimer.cancel();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Forgot Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isButtonDisabled ? null : _startCooldown,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Set the button color to purple
                  padding: EdgeInsets.symmetric(vertical: 16), // Increase button height
                ),
                child: Text(
                  _isButtonDisabled ? 'Cooldown ($_cooldownRemaining s)' : 'Send Reset Link',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ForgotPasswordPage(),
  ));
}
