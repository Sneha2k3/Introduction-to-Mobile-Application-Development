import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/UserModel.dart';

class UserRepository {
  CollectionReference<UserModel> instance = FirebaseFirestore.instance
      .collection("Users")
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );

  Future<UserModel?> getUserDetail(String? id) async {
    try {
      final response = await instance.doc(id).get();
      var user = response.data();
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> addUserDetails(UserModel data) async {
    try {
      final user = await instance.add(data);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserDetail(String? id, UserModel data) async {
    try {
      await instance.doc(id).set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserDetail(String? id) async {
    try {
      await instance.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
