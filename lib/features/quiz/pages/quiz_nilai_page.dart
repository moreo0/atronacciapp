import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/quiz/model/quiz_submission_response.dart';

@RoutePage()
class QuizNilaiPage extends StatefulWidget {
  final QuizSubmissionResponse submissionResponse;
  final int totalSoal;
  const QuizNilaiPage({
    super.key,
    required this.submissionResponse,
    required this.totalSoal,
  });

  @override
  State<QuizNilaiPage> createState() => _QuizNilaiPageState();
}

class _QuizNilaiPageState extends State<QuizNilaiPage> {
  @override
  Widget build(BuildContext context) {
    final response = widget.submissionResponse;
    final user = response.data.user;
    // final exam = response.data.exam;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Nilai Quiz',
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 155,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffD0CECE),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LeftAlignedColumn(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: ClipOval(
                              child: Image.network(
                                user!.profileImage ??
                                    'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ).rightPadded(20),
                          LeftAlignedColumn(
                            children: [
                              Row(
                                children: [
                                  LimitedBox(
                                    maxWidth: 200,
                                    child: Text(
                                      user.name,
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
                              Text(
                                response.data.createdAt!
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0],
                                style: AppStyle.body2(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black.withOpacity(0.4)),
                              )
                            ],
                          )
                        ],
                      ).bottomPadded24(),
                      Row(
                        children: [
                          Text(
                            'Jawaban Benar : ',
                            style: AppStyle.body2(fontWeight: FontWeight.bold),
                          ).rightPadded16(),
                          Text(
                            '${response.data.correct}/${widget.totalSoal}',
                            style: AppStyle.body2(fontWeight: FontWeight.bold),
                          ).rightPadded16(),
                        ],
                      ).bottomPadded6(),
                      Row(
                        children: [
                          Text(
                            'Nilai : ',
                            style: AppStyle.body2(fontWeight: FontWeight.bold),
                          ).rightPadded16(),
                          Text(
                            response.data.score!.toStringAsFixed(1),
                            style: AppStyle.body2(fontWeight: FontWeight.bold),
                          ).rightPadded16(),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(100, 0, 100, 40),
        child: GestureDetector(
          onTap: () {
            context.router.replace(const MainRoute());
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
                'Kembali',
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
