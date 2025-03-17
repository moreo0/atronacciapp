import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/profile/provider/edit_user_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:univs/features/profile/provider/get_user_provider.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  final String name;
  final String dateOfBirth;
  final String university;
  final String gender;
  final String imageUrl;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.dateOfBirth,
    required this.university,
    required this.gender,
    required this.imageUrl,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  late EditUserProvider _editUserProvider;
  late GetUserProvider _getUserProvider;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    dateController.text = widget.dateOfBirth;
    universityController.text = widget.university;
    genderController.text = widget.gender;
    _editUserProvider = Provider.of<EditUserProvider>(context, listen: false);
    _getUserProvider = Provider.of<GetUserProvider>(context, listen: false);
  }

  File? _imageFile;
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _uploadImageToFirebase();
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_imageFile == null) return;
    try {
      String imageName =
          '${DateTime.now().millisecondsSinceEpoch}${_imageFile!.path.split('.').last}';
      TaskSnapshot uploadTask = await _storage
          .ref()
          .child('images/{$imageName}')
          .putFile(_imageFile!);
      String downloadURL = await uploadTask.ref.getDownloadURL();
      setState(() {
        _imageUrl = downloadURL;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  if (_imageFile != null)
                    ClipOval(
                      child: Image.file(
                        File(
                          _imageFile!.path,
                        ),
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ).bottomPadded20(),
                  if (_imageFile == null)
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: ClipOval(
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).bottomPadded20(),
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Text(
                      'Edit Picture',
                      style: AppStyle.subtitle3(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).bottomPadded24(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Name',
                      style: AppStyle.body1(),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      // validator: _validateText,
                      style: AppStyle.body1(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ).bottomPadded12(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Date of birth',
                      style: AppStyle.body1(),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: dateController,
                      // validator: _validateText,
                      style: AppStyle.body1(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ).bottomPadded12(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'University',
                      style: AppStyle.body1(),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: universityController,
                      // validator: _validateText,
                      style: AppStyle.body1(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ).bottomPadded12(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Gender',
                      style: AppStyle.body1(),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: genderController,
                      // validator: _validateText,
                      style: AppStyle.body1(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ).bottomPadded20(),
                  GestureDetector(
                    onTap: () async {
                      if (nameController.text.isEmpty ||
                          dateController.text.isEmpty ||
                          universityController.text.isEmpty ||
                          genderController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Mohon isi semua field');
                      } else if (universityController.text == '-' ||
                          genderController.text == '-') {
                        Fluttertoast.showToast(
                            msg: 'Isi universitas dan gender dengan lengkap');
                      } else {
                        await _uploadImageToFirebase();
                        await _editUserProvider.doEditUsers(
                          // ignore: use_build_context_synchronously
                          context: context,
                          name: nameController.text,
                          image:
                              _imageUrl == null ? widget.imageUrl : _imageUrl!,
                          gender: genderController.text,
                          university: universityController.text,
                          dateOfBirth: dateController.text,
                        );
                        // ignore: use_build_context_synchronously
                        _getUserProvider.doGetUsers();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xff628BF5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Update Profile',
                          style: AppStyle.body1(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
