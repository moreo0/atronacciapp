import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/assets.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/quiz/provider/get_quiz_detail_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class QuizDetailPage extends StatefulWidget {
  final int id;
  final String quizName;
  const QuizDetailPage({
    super.key,
    required this.id,
    required this.quizName,
  });

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  late GetQuizDetailProvider _getQuizProvider;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getQuizProvider =
          Provider.of<GetQuizDetailProvider>(context, listen: false);
      _getQuizProvider.doGetQuizDetails(id: widget.id.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.quizName,
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
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
                var quiz = provider.quizDetailResponse!.data;
                return Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: Image.network(
                          quiz.imageUrl ??
                              'https://cdn.elearningindustry.com/wp-content/uploads/2021/10/Shareable-Quizzes-In-Online-Training-7-Reasons.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).topPadded(30).bottomPadded(50),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ).bottomPadded(30),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: ClipOval(
                            child: Image.network(
                              quiz.user.image ??
                                  'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).rightPadded(20),
                        Row(
                          children: [
                            LimitedBox(
                              maxWidth: 200,
                              child: Text(
                                quiz.user.name,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.body1(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (quiz.user.university != null)
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
                                quiz.user.university ?? '',
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
                    ).leftPadded(20).bottomPadded24(),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            Assets.imgMateri,
                            fit: BoxFit.cover,
                          ),
                        ).rightPadded(20),
                        LimitedBox(
                          maxWidth: 250,
                          child: Text(
                            quiz.category,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.body1(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ).leftPadded(20).bottomPadded24(),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            Assets.imgSoal,
                            fit: BoxFit.cover,
                          ),
                        ).rightPadded(20),
                        Text(
                          '${quiz.examDetails.length.toString()} Soal',
                          style: AppStyle.body1(fontWeight: FontWeight.bold),
                        )
                      ],
                    ).leftPadded(20).bottomPadded(30),
                    Divider(
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    ).bottomPadded24(),
                    GestureDetector(
                      onTap: () {
                        context.router.replaceAll([QuizSoalRoute(id: quiz.id)]);
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
                            'Mulai Quiz',
                            style: AppStyle.body1(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
