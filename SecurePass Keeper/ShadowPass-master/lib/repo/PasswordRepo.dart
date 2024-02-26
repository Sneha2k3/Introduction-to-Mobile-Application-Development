import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/PasswordModel.dart';
import '../Services/firebase_services.dart';


class PasswordRepository {
  CollectionReference<PasswordModel> instance = FirebaseFirestore.instance
      .collection("Passwords")
      .withConverter<PasswordModel>(
    fromFirestore: (snapshot, _) {
      return PasswordModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );

  Future<dynamic> addPassword(PasswordModel data) async {
    try {
      final password = await instance.add(data);
      data.pid=password.id;
      updatePassword(password.id, data);
      return password;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(String? id, PasswordModel data) async {
    try {
      await instance.doc(id).set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<PasswordModel>>> getAllPasswords(String? userId) async {
    try {
      var response = await instance.where("uid", isEqualTo: userId).get();
      var passwords = response.docs;
      return passwords;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePassword(String id) async {
    try {
      print('Deleting document with ID: $id');
      await instance.doc(id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DocumentSnapshot<PasswordModel>> getOnePassword(String id) async {
    try {
      final response = await instance.doc(id).get();
      if (!response.exists) {
        throw Exception("Password get one password does not exist");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<PasswordModel>>> getMyPasswords(String userId) async {
    try {
      final response = await instance.where("userId", isEqualTo: userId).get();
      var passwords = response.docs;
      return passwords;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
