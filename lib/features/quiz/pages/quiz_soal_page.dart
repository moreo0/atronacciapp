// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/quiz/provider/get_quiz_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:univs/features/quiz/provider/submit_quiz_provider.dart';

@RoutePage()
class QuizSoalPage extends StatefulWidget {
  final int id;
  const QuizSoalPage({super.key, required this.id});

  @override
  State<QuizSoalPage> createState() => _QuizSoalPageState();
}

class _QuizSoalPageState extends State<QuizSoalPage> {
  List<int?> selectedSoals = [];
  late GetQuizDetailProvider _getQuizProvider;
  late SubmitQuizProvider _submitQuizProvider;

  @override
  void initState() {
    super.initState();
    _submitQuizProvider =
        Provider.of<SubmitQuizProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _getQuizProvider =
          Provider.of<GetQuizDetailProvider>(context, listen: false);
      _getQuizProvider.doGetQuizDetails(id: widget.id.toString());
    });
  }

  void setSelectedSoal(int questionIndex, int value) {
    setState(() {
      selectedSoals[questionIndex] = value;
    });
  }

  Future<void> submitQuiz() async {
    if (selectedSoals.contains(null)) {
      Fluttertoast.showToast(msg: 'Isi semua jawaban');
      return;
    }

    final List<Map<String, dynamic>> examResponses = [];
    final examDetails = _getQuizProvider.quizDetailResponse!.data.examDetails;

    for (int i = 0; i < selectedSoals.length; i++) {
      if (selectedSoals[i] != null) {
        examResponses.add({
          "examDetailsId": examDetails[i].id,
          "answer": String.fromCharCode(65 + (selectedSoals[i]! - 1)),
        });
      }
    }

    final response = {
      "examId": widget.id,
      "examResponses": examResponses,
    };

    print(jsonEncode(response));

    // Submit the quiz
    await _submitQuizProvider.doSubmitQuizs(
      context: context,
      examId: widget.id,
      examResponses: examResponses,
      totalSoal: _getQuizProvider.quizDetailResponse!.data.examDetails.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Quiz Fisika',
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Consumer<GetQuizDetailProvider>(
              builder: (_, provider, __) {
                if (provider.isLoading) {
                  return Center(
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      elevation: 10,
                      child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  );
                }
                if (provider.isLoaded) {
                  if (provider.quizDetailResponse!.data.examDetails.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Oops, belum ada soal',
                                style: AppStyle.body1()),
                          ],
                        ),
                      ),
                    );
                  } else {
                    if (selectedSoals.length !=
                        provider.quizDetailResponse!.data.examDetails.length) {
                      selectedSoals = List<int?>.filled(
                          provider.quizDetailResponse!.data.examDetails.length,
                          null);
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          provider.quizDetailResponse!.data.examDetails.length,
                      itemBuilder: (context, index) {
                        var soal = provider
                            .quizDetailResponse!.data.examDetails[index];
                        return LeftAlignedColumn(
                          children: [
                            Text(
                              '${index + 1}. ${soal.question}',
                              style:
                                  AppStyle.body1(fontWeight: FontWeight.bold),
                            ).bottomPadded6(),
                            RadioListTile(
                              dense: true,
                              value: 1,
                              groupValue: selectedSoals[index],
                              onChanged: (val) {
                                setSelectedSoal(index, val!);
                              },
                              contentPadding: const EdgeInsets.all(0),
                              title:
                                  Text(soal.option1, style: AppStyle.body1()),
                            ),
                            RadioListTile(
                              dense: true,
                              value: 2,
                              groupValue: selectedSoals[index],
                              onChanged: (val) {
                                setSelectedSoal(index, val!);
                              },
                              contentPadding: const EdgeInsets.all(0),
                              title:
                                  Text(soal.option2, style: AppStyle.body1()),
                            ),
                            RadioListTile(
                              dense: true,
                              value: 3,
                              groupValue: selectedSoals[index],
                              onChanged: (val) {
                                setSelectedSoal(index, val!);
                              },
                              contentPadding: const EdgeInsets.all(0),
                              title:
                                  Text(soal.option3, style: AppStyle.body1()),
                            ),
                            RadioListTile(
                              dense: true,
                              value: 4,
                              groupValue: selectedSoals[index],
                              onChanged: (val) {
                                setSelectedSoal(index, val!);
                              },
                              contentPadding: const EdgeInsets.all(0),
                              title:
                                  Text(soal.option4, style: AppStyle.body1()),
                            ),
                            RadioListTile(
                              dense: true,
                              value: 5,
                              groupValue: selectedSoals[index],
                              onChanged: (val) {
                                setSelectedSoal(index, val!);
                              },
                              contentPadding: const EdgeInsets.all(0),
                              title:
                                  Text(soal.option5, style: AppStyle.body1()),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(100, 0, 100, 40),
        child: GestureDetector(
          onTap: () {
            if (!selectedSoals.contains(null)) {
              submitQuiz();
            } else {
              Fluttertoast.showToast(msg: 'Isi semua jawaban');
            }
          },
          child: Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: const Color(0xffFA4E28),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Selesai',
                style: AppStyle.body1(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
