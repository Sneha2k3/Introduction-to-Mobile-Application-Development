// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../Services/firebase_services.dart';
// import '../models/PasswordModel.dart'; // Make sure you have defined PasswordModel
// import '../repo/PasswordRepo.dart';
//
// class PasswordViewModel with ChangeNotifier {
//   final User? _user = FirebaseService.firebaseAuth.currentUser;
//   User? get user => _user;
//   PasswordRepository _passwordRepository = PasswordRepository();
//   List<PasswordModel> _passwords = [];
//   List<PasswordModel> get passwords => _passwords;
//   PasswordModel? _selectedPassword;
//   PasswordModel? get selectedPassword => _selectedPassword;
//
//   Future<void> getAllPasswords() async {
//     try {
//       var response = await _passwordRepository.getAllPasswords(_user?.uid);
//       _passwords = response.map((element) => element.data()).cast<PasswordModel>().toList();
//       notifyListeners();
//     } catch (e) {
//       print(e);
//       _passwords = [];
//       notifyListeners();
//     }
//   }
//
//   Future<void> getOnePassword(String id) async {
//     try {
//       var response = await _passwordRepository.getOnePassword(id);
//       if (response != null) {
//         _selectedPassword = response.data();
//         notifyListeners();
//       }
//     } catch (e) {
//       print(e);
//       _selectedPassword = null;
//       notifyListeners();
//     }
//   }
//
//   Future<void> addPassword(PasswordModel password) async {
//     try {
//       await _passwordRepository.addPassword(password);
//       notifyListeners();
//     } catch (e) {
//       print(e);
//       notifyListeners();
//     }
//   }
//
//   Future<void> updatePassword(String id, PasswordModel data) async {
//     try {
//       await _passwordRepository.updatePassword(id, data);
//       await getAllPasswords();
//       notifyListeners();
//     } catch (e) {
//       print(e);
//       notifyListeners();
//     }
//   }
//
//   Future<void> deletePassword(String id) async {
//     try {
//       await _passwordRepository.deletePassword(id);
//       await getAllPasswords();
//       notifyListeners();
//     } catch (e) {
//       print(e);
//       notifyListeners();
//     }
//   }
// }
