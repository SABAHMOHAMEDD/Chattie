import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../features/login/pages/login_screen.dart';
import '../cache_helper.dart';

const String KLogo = "assets/images/scholar.png";
const String emaxCollection = "emaxmessages";
const String MogaCollection = "mogaMessages";
const Color KprimaryColor = Colors.blueGrey;
const String kCreatedAt = "createdAt";
final String? uId = CacheHelper.getData(key: 'uId');

void SignOut(context) async {
  await FirebaseAuth.instance.signOut();
  // removeDocument();
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      print("44444444444444444444444");
      print(CacheHelper.getData(key: 'uId'));
      print("44444444444444444444444");
    }
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
