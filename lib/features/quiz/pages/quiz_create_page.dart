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
import 'package:univs/core/utils/assets.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/quiz/provider/create_quiz_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class QuizCreatePage extends StatefulWidget {
  const QuizCreatePage({super.key});

  @override
  State<QuizCreatePage> createState() => _QuizCreatePageState();
}

class _QuizCreatePageState extends State<QuizCreatePage> {
  TextEditingController judulQuiz = TextEditingController();
  TextEditingController kategoriQuiz = TextEditingController();
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  TextEditingController option5 = TextEditingController();

  late CreateQuizProvider _createQuizProvider;

  String? selectedSoal;

  @override
  void initState() {
    super.initState();
    _createQuizProvider =
        Provider.of<CreateQuizProvider>(context, listen: false);
    selectedSoal = 'A';
  }

  setSelectedSoal(String val) {
    setState(() {
      selectedSoal = val;
    });
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

  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(n) {
    setState(() {
      _items.add(n);
    });
  }

  void deleteItem(i) {
    setState(() {
      _items.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Buat Quiz',
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            IntrinsicHeight(
                child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xffD0CECE),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: LeftAlignedColumn(
                  children: [
                    Text(
                      'Judul',
                      style: AppStyle.body1(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: judulQuiz,
                      style: AppStyle.body1(),
                      decoration: InputDecoration(
                        hintText: 'Judul quiz kamu..',
                        hintStyle: AppStyle.body1(),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0, // Set the width of the border
                          ),
                        ),
                      ),
                    ).bottomPadded12(),
                    Text(
                      'Kategori',
                      style: AppStyle.body1(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: kategoriQuiz,
                      style: AppStyle.body1(),
                      decoration: InputDecoration(
                        hintText: 'Kategori quiz kamu..',
                        hintStyle: AppStyle.body1(),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0, // Set the width of the border
                          ),
                        ),
                      ),
                    ).bottomPadded12(),
                    Text(
                      'Gambar',
                      style: AppStyle.body1(fontWeight: FontWeight.bold),
                    ).bottomPadded16(),
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: const Icon(
                        IconlyLight.image,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    if (_imageFile != null)
                      Image.file(
                        File(
                          _imageFile!.path,
                        ),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              ),
            )).bottomPadded12(),
            IntrinsicHeight(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffD0CECE),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: LeftAlignedColumn(
                    children: [
                      Text(
                        'Pertanyaan',
                        style: AppStyle.body1(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: question,
                        style: AppStyle.body1(),
                        decoration: InputDecoration(
                          hintText: 'Masukan pertanyaan..',
                          hintStyle: AppStyle.body1(),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0, // Set the width of the border
                            ),
                          ),
                        ),
                      ).bottomPadded12(),
                      Text(
                        'Jawaban',
                        style: AppStyle.body1(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Image.asset(Assets.icCircle),
                          ).rightPadded16(),
                          Expanded(
                            child: TextField(
                              controller: option1,
                              style: AppStyle.body1(),
                              decoration: InputDecoration(
                                hintText: 'Opsi 1',
                                hintStyle: AppStyle.body1(),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0, // Set the width of the border
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).bottomPadded6(),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Image.asset(Assets.icCircle),
                          ).rightPadded16(),
                          Expanded(
                            child: TextField(
                              controller: option2,
                              style: AppStyle.body1(),
                              decoration: InputDecoration(
                                hintText: 'Opsi 2',
                                hintStyle: AppStyle.body1(),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0, // Set the width of the border
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).bottomPadded6(),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Image.asset(Assets.icCircle),
                          ).rightPadded16(),
                          Expanded(
                            child: TextField(
                              controller: option3,
                              style: AppStyle.body1(),
                              decoration: InputDecoration(
                                hintText: 'Opsi 3',
                                hintStyle: AppStyle.body1(),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0, // Set the width of the border
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).bottomPadded6(),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Image.asset(Assets.icCircle),
                          ).rightPadded16(),
                          Expanded(
                            child: TextField(
                              controller: option4,
                              style: AppStyle.body1(),
                              decoration: InputDecoration(
                                hintText: 'Opsi 4',
                                hintStyle: AppStyle.body1(),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0, // Set the width of the border
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).bottomPadded16(),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Image.asset(Assets.icCircle),
                          ).rightPadded16(),
                          Expanded(
                            child: TextField(
                              controller: option5,
                              style: AppStyle.body1(),
                              decoration: InputDecoration(
                                hintText: 'Opsi 5',
                                hintStyle: AppStyle.body1(),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0, // Set the width of the border
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).bottomPadded16(),
                      Text(
                        'Pilih jawaban yang benar',
                        style: AppStyle.body1(fontWeight: FontWeight.bold),
                      ).bottomPadded6(),
                      RadioListTile(
                        dense: true,
                        value: 'A',
                        groupValue: selectedSoal,
                        onChanged: (val) {
                          setSelectedSoal(val!);
                        },
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          'Option 1',
                          style: AppStyle.body1(),
                        ),
                      ),
                      RadioListTile(
                        dense: true,
                        value: 'B',
                        groupValue: selectedSoal,
                        onChanged: (val) {
                          setSelectedSoal(val!);
                        },
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          'Option 2',
                          style: AppStyle.body1(),
                        ),
                      ),
                      RadioListTile(
                        dense: true,
                        value: 'C',
                        groupValue: selectedSoal,
                        onChanged: (val) {
                          setSelectedSoal(val!);
                        },
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          'Option 3',
                          style: AppStyle.body1(),
                        ),
                      ),
                      RadioListTile(
                        dense: true,
                        value: 'D',
                        groupValue: selectedSoal,
                        onChanged: (val) {
                          setSelectedSoal(val!);
                        },
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          'Option 4',
                          style: AppStyle.body1(),
                        ),
                      ),
                      RadioListTile(
                        dense: true,
                        value: 'E',
                        groupValue: selectedSoal,
                        onChanged: (val) {
                          setSelectedSoal(val!);
                        },
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          'Option 5',
                          style: AppStyle.body1(),
                        ),
                      ),
                    ],
                  ),
                ),
              ).bottomPadded12(),
            ),
            GestureDetector(
              onTap: () {
                if (question.text.isEmpty ||
                    option1.text.isEmpty ||
                    option2.text.isEmpty ||
                    option3.text.isEmpty ||
                    option4.text.isEmpty ||
                    option5.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Isi pertanyan dan soal-soal terlebih dahulu');
                } else {
                  addItem({
                    'question': question.text,
                    'option1': option1.text,
                    'option2': option2.text,
                    'option3': option3.text,
                    'option4': option4.text,
                    'option5': option5.text,
                    'key': selectedSoal.toString(),
                  });
                  Fluttertoast.showToast(msg: 'Berhasil tambah soal');
                  question.clear();
                  option1.clear();
                  option2.clear();
                  option3.clear();
                  option4.clear();
                  option5.clear();
                  setSelectedSoal('A');
                }
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffD0CECE),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Tambah Soal',
                    style: AppStyle.body1(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ).bottomPadded16(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Wrap(
                runSpacing: 0,
                spacing: 8,
                children: List.generate(
                  _items.length,
                  (index) {
                    return Chip(
                      label: SizedBox(
                        width: 100,
                        child: Text(
                          _items[index]['question']!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      deleteIcon: const Icon(Icons.clear),
                      onDeleted: () => deleteItem(index),
                    );
                  },
                ),
              ),
            ).bottomPadded12(),
            GestureDetector(
              onTap: () {
                if (judulQuiz.text.isEmpty ||
                    kategoriQuiz.text.isEmpty ||
                    items.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Isi semua field terlebih dahulu');
                } else {
                  _createQuizProvider.doCreateQuizs(
                      context: context,
                      title: judulQuiz.text,
                      imageUrl: _imageUrl!,
                      category: kategoriQuiz.text,
                      examDetails: items);
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
                    'Buat Quiz',
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
      )),
    );
  }
}
