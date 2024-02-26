import 'package:flutter/material.dart';
import '../Models/PasswordModel.dart';
import '../repo/PasswordRepo.dart';
import 'editPassword.dart';

class PasswordDetailPage extends StatelessWidget {
  final PasswordModel password;
  final PasswordRepository passwordRepository =
  PasswordRepository(); // Import and initialize your PasswordRepository

  PasswordDetailPage({required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              password.title ?? "No Title",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Username: ${password.username ?? "No Username"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Website: ${password.website ?? "No Website"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Password: ${password.password ?? "No Password"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Note: ${password.note ?? "No Note"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPasswordPage(password: password),
                    ),
                  );
                },
                child: Text('Edit', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _deletePassword(context); // Use the repository delete method
                },
                child: Text('Delete', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method to delete password using the repository
  Future<void> _deletePassword(BuildContext context) async {
    try {
      await passwordRepository.deletePassword(password.pid!);
      Navigator.pushNamed(context,
          "/home"); // Navigate back to the previous screen after deletion
    } catch (e) {
      print(e);
      // Show error message or snackbar here
    }
  }
}
