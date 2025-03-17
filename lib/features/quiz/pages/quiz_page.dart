import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/quiz/provider/get_quiz_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  TextEditingController searchC = TextEditingController();

  late GetQuizProvider _getQuizProvider;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getQuizProvider = Provider.of<GetQuizProvider>(context, listen: false);
      _getQuizProvider.doGetQuizs();
    });

    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await _getQuizProvider.doGetQuizs();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListView(
            children: [
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffD0CECE),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: AppStyle.body2(color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: AppStyle.body2(color: Colors.black),
                          controller: searchC,
                          onChanged: (value) {
                            _getQuizProvider.filterQuiz(value);
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ).bottomPadded(30).topPadded(50),
              Text(
                'Quiz',
                style: AppStyle.subtitle1(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Consumer<GetQuizProvider>(
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
                    if (provider.filteredQuiz.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Oops, belum ada quiz',
                                  style: AppStyle.body1()),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.filteredQuiz.length,
                        itemBuilder: (context, index) {
                          var quiz = provider.filteredQuiz[index];
                          return GestureDetector(
                            onTap: () {
                              context.router.push(QuizDetailRoute(
                                id: quiz.id,
                                quizName: quiz.title,
                              ));
                            },
                            child: Container(
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffD0CECE),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  LimitedBox(
                                    maxWidth: 200,
                                    child: Text(
                                      quiz.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyle.subtitle4(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ).leftPadded16(),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios)
                                      .rightPadded16()
                                ],
                              ),
                            ),
                          ).bottomPadded16();
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.router.push(const ChatAIRoute());
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD9D9D9),
                ),
                child: const Center(
                  child: Icon(Icons.comment),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.router.push(const QuizCreateRoute());
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD9D9D9),
                ),
                child: const Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
