import 'package:flutter/material.dart';
import '../Models/PasswordModel.dart';
import '../repo/PasswordRepo.dart';

class EditPasswordPage extends StatefulWidget {
  final PasswordModel password;

  EditPasswordPage({required this.password});

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final PasswordRepository _passwordRepository = PasswordRepository();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _usernameController;
  late TextEditingController _websiteController;
  late TextEditingController _passwordController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.password.title);
    _usernameController = TextEditingController(text: widget.password.username);
    _websiteController = TextEditingController(text: widget.password.website);
    _passwordController = TextEditingController(text: widget.password.password);
    _noteController = TextEditingController(text: widget.password.note);
  }

  Future<void> _editPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        var editedPassword = PasswordModel(
          pid: widget.password.pid,
          uid: widget.password.uid,
          title: _titleController.text,
          username: _usernameController.text,
          website: _websiteController.text,
          password: _passwordController.text,
          note: _noteController.text,
        );
        await _passwordRepository.updatePassword(editedPassword.pid, editedPassword);
        Navigator.pushNamed(context, "/home"); // Navigate back to the previous screen after editing
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _websiteController.dispose();
    _passwordController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                style: TextStyle(color: Colors.white), // Change text color to white
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white), // Change text color to white
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  // Add username validation logic here
                  return null;
                },
              ),
              TextFormField(
                controller: _websiteController,
                style: TextStyle(color: Colors.white), // Change text color to white
                decoration: InputDecoration(labelText: 'Website'),
                validator: (value) {
                  // Add website validation logic here
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white), // Change text color to white
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  // Add password validation logic here
                  return null;
                },
              ),
              TextFormField(
                controller: _noteController,
                style: TextStyle(color: Colors.white), // Change text color to white
                maxLines: 5, // To make the note part bigger
                decoration: InputDecoration(labelText: 'Note'),
                validator: (value) {
                  // Add note validation logic here
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _editPassword,
                child: Text('Edit Password', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Use purple as the button color
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
