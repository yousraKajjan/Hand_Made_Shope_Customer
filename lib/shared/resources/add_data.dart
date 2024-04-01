import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName).child('id');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {BuildContext? context,
      required String name,
      required String phoneNumber,
      required String email,
      required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try {
      if (name.isNotEmpty || phoneNumber.isNotEmpty) {
        String imagUrl = await uploadImageToStorage('profileImage', file);
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseFirestore.instance
              .collection("userProfileSingUp")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
            'name': name,
            'phoneNumber': phoneNumber,
            'email': email,
            'imageLink': imagUrl
          });
          print("finish write");
        } else {
          print('non fire store');
        }
        // await firestore.collection('userProfileSingUp').add({
        //   'name': name,
        //   'phoneNumber': phoneNumber,
        //   'email': email,
        //   'imageLink': imagUrl
        // });

        // }

        resp = 'Success';
      } else {
        ScaffoldMessenger.of(context!).showSnackBar(
          const SnackBar(
            content: Text('Empty name'),
          ),
        );
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
