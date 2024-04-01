import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_namaa/testaddimage/resources/add_data.dart';
import 'package:project_namaa/testaddimage/util.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery, context);
    setState(() {
      image = img;
    });
  }

  void saveProfile() async {
    String name = nameController.text;
    String bio = nameController.text;
    String resp =
        await StoreData().saveData(name: name, bio: bio, file: image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.grey,
                        backgroundImage: MemoryImage(image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        child: Image.asset(
                          'asset/images/avatar.png',
                          width: 150.w,
                        ),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                hintText: 'Enter Bio',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: saveProfile,
              child: const Text('save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
