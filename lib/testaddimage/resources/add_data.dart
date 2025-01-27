import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      required String bio,
      required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try {
      if (name.isNotEmpty || bio.isNotEmpty) {
        String imagUrl = await uploadImageToStorage('profileImage', file);
        await firestore
            .collection('userProfile')
            .add({'name': name, 'bio': bio, 'imageLink': imagUrl});

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
