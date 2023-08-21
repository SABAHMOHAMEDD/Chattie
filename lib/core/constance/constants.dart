import 'package:chat_tharwat/features/splash/pages/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/register/models/user_model.dart';
import '../cache_helper.dart';

const String KLogo = "assets/images/scholar.png";
const String usersCollection = "users";
const String emaxCollection = "emaxmessages";
const String MogaCollection = "mogaMessages";
const String privateChatCollection = "chats";
const String privateMessagesCollection = "messages";
const Color KprimaryColor = Colors.blueGrey;
const String kCreatedAt = "createdAt";
final String? uId = CacheHelper.getData(key: 'uId');

void SignOut(context) async {
  await CacheHelper.init();
  final String? uId = CacheHelper.getData(key: 'uId');
  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(uId);
  print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
  clearCachedData();
  await FirebaseAuth.instance.signOut();
  CacheHelper.removeData(key: 'userId');
  CacheHelper.removeData(key: 'name');
  CacheHelper.removeData(key: 'email');
  CacheHelper.removeData(key: 'userImage');
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      Navigator.pushReplacementNamed(context, SplashScreen.routeName);
      print("44444444444444444444444");
      print(CacheHelper.getData(key: 'uId'));
      print("44444444444444444444444");
    }
  });
  RemoveUserData();
}

UserModel? model;

void RemoveUserData() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(CacheHelper.getData(key: 'uId'))
      .delete()
      .then((value) {
    print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    print(model!.uId);
    print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  }).catchError((error) {
    print(error.toString());
  });
}

void removeDocument() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Specify the path to the document you want to remove
  String documentPath =
      'users/uId'; // Replace with your collection name and document ID

  // Get the reference to the document
  DocumentReference documentReference = firestore.doc(documentPath);

  // Delete the document
  documentReference.delete().then((_) {
    print('Document removed successfully.');
  }).catchError((error) {
    print('Failed to remove document: $error');
  });
}

void clearCachedData() async {
  final storage = FlutterSecureStorage();

  // Delete the cached data
  await storage.deleteAll();

  print('Cached data cleared successfully.');
}
