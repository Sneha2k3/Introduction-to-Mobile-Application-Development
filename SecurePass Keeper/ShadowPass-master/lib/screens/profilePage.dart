import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shadowpass/Services/firebase_services.dart';
import 'package:shadowpass/repo/UserRepository.dart';
import '../Models/UserModel.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepository _userRepository = UserRepository();
  UserModel? _user;
  FirebaseAuth _auth = FirebaseService.firebaseAuth;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    try {
      if (_auth.currentUser != null) {
        String? userId = _auth.currentUser?.uid;
        UserModel? user = await _userRepository.getUserDetail(userId);
        setState(() {
          _user = user;
        });
      } else {
        // Redirect to login page or handle authentication state accordingly
        print("User not authenticated");
      }
    } catch (e) {
      print("Error loading user details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _user != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileDetail('First Name:', _user!.firstName),
            buildProfileDetail('Last Name:', _user!.lastName),
            buildProfileDetail('Gender:', _user!.gender),
            buildProfileDetail('Date of Birth:', _user!.dob),
            buildProfileDetail('Email:', _user!.email),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildProfileDetail(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(value ?? "N/A", style: TextStyle(fontSize: 16)),
        SizedBox(height: 12),
      ],
    );
  }
}
