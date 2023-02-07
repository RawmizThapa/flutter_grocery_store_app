import 'package:flutter/material.dart';

class AmazonLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://www.freepnglogos.com/uploads/amazon-png-logo-vector/amazon-png-logo-vector-1.png'),
            const SizedBox(height: 24.0),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email or mobile phone number',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                // Perform login action
              },
            ),
            TextButton(
              child: const Text('Create your Amazon account'),
              onPressed: () {
                // Navigate to sign up screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
