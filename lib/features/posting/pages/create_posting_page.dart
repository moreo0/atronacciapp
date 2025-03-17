import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/core/utils/show_loading_dialog.dart';
import 'package:univs/core/utils/widget/loading_shimmer.dart';
import 'package:univs/features/posting/provider/create_post_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:univs/features/profile/provider/get_user_provider.dart';

@RoutePage()
class CreatePostingPage extends StatefulWidget {
  const CreatePostingPage({super.key});

  @override
  State<CreatePostingPage> createState() => _CreatePostingPageState();
}

class _CreatePostingPageState extends State<CreatePostingPage> {
  late CreatePostProvider _createPostProvider;
  late GetUserProvider _getUserProvider;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    _createPostProvider =
        Provider.of<CreatePostProvider>(context, listen: false);
    _getUserProvider = Provider.of<GetUserProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _getUserProvider.doGetUsers();
    });
    super.initState();
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Consumer<GetUserProvider>(
              builder: (_, provider, __) {
                if (provider.isLoading) {
                  return const LoadingShimmer(
                    height: 50,
                    width: double.infinity,
                  );
                }
                if (provider.isLoaded) {
                  if (provider.userResponse!.data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Oops', style: AppStyle.body1()),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.userResponse!.data.length,
                      itemBuilder: (context, index) {
                        var user = provider.userResponse!.data[index];
                        return Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: ClipOval(
                                child: Image.network(
                                  user.image ??
                                      'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ).rightPadded16(),
                            Row(
                              children: [
                                LimitedBox(
                                  maxWidth: 200,
                                  child: Text(
                                    user.name!,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.body1(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (user.university != null)
                                  Text(
                                    ' - ',
                                    style: AppStyle.body1(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                LimitedBox(
                                  maxWidth: 150,
                                  child: Text(
                                    user.university ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.body1(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ).bottomPadded6(),
                          ],
                        ).bottomPadded24();
                      },
                    );
                  }
                }
                return const SizedBox();
              },
            ),
            IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffD0CECE),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: const Icon(
                          IconlyLight.image,
                          color: Colors.black,
                          size: 25,
                        ),
                      ).bottomPadded16(),
                      if (_imageFile != null)
                        Image.file(
                          File(
                            _imageFile!.path,
                          ),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      Container(
                        color: const Color(0xffD0CECE),
                        child: TextField(
                          controller: commentController,
                          style: AppStyle.body1(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          maxLines: 6,
                          decoration: const InputDecoration(
                            hintText: "Write comment here...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).bottomPadded20(),
            GestureDetector(
              onTap: () async {
                if (commentController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Isi comment terlebih dahulu');
                } else {
                  try {
                    Dialogs.show(context);
                    await _uploadImageToFirebase();
                    await _createPostProvider.doCreatePosts(
                      description: commentController.text,
                      attachment: _imageUrl,
                    );
                    setState(() {
                      _imageUrl = null;
                      _imageFile = null;
                      commentController.clear();
                      Dialogs.dismiss(context);
                    });
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    Dialogs.dismiss(context);
                    Fluttertoast.showToast(msg: 'Error $e');
                  }
                }
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xFF3F8AFB),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'Post',
                    style: AppStyle.subtitle4(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
