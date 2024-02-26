import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PasswordModel PasswordModelFromJson(String str) => PasswordModel.fromJson(json.decode(str));

String PasswordModelToJson(PasswordModel data) => json.encode(data.toJson());


class PasswordModel {
  String? uid;
  String? title;
  String? username;
  String? website;
  String? password;
  String? note;
  String? pid;

  PasswordModel({
    this.username,
    this.uid,
    this.title,
    this.website,
    this.password,
    this.note,
    this.pid,
  });

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
    uid: json["uid"],
    title: json["Title"],
    username: json["username"],
    website: json["website"],
    password: json["password"],
    note: json["note"],
    pid: json["pid"],
  );
  factory PasswordModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => PasswordModel(
    uid: json["uid"],
    title: json["Title"],
    username: json["username"],
    website: json["website"],
    password: json["password"],
    note: json["note"],
    pid: json["pid"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "Title": title,
    "username":username,
    "website": website,
    "password": password,
    "note": note,
    "pid": pid,
  };
}
