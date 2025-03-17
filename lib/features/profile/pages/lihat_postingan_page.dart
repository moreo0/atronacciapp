import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/core/utils/widget/loading_shimmer.dart';
import 'package:univs/features/home/model/post_model.dart';
import 'package:univs/features/home/provider/comment_provider.dart';
import 'package:univs/features/home/provider/delete_delete_provider.dart';
import 'package:univs/features/home/provider/get_postByUser_provider.dart';

import 'package:univs/features/profile/provider/get_user_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LihatPostinganPage extends StatefulWidget {
  const LihatPostinganPage({super.key});

  @override
  State<LihatPostinganPage> createState() => _LihatPostinganPageState();
}

class _LihatPostinganPageState extends State<LihatPostinganPage> {
  TextEditingController commentController = TextEditingController();
  late GetPostByUserProvider _getPostByUserProvider;
  late CommentProvider _commentProvider;
  late GetUserProvider _getUserProvider;
  late DeletePostsProvider _deletePostsProvider;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await _getPostByUserProvider.doGetPostByUsers();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _commentProvider = Provider.of<CommentProvider>(context, listen: false);
    _getUserProvider = Provider.of<GetUserProvider>(context, listen: false);
    _deletePostsProvider =
        Provider.of<DeletePostsProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      _getPostByUserProvider =
          Provider.of<GetPostByUserProvider>(context, listen: false);
      _getPostByUserProvider.doGetPostByUsers();
      _getUserProvider.doGetUsers();
    });
    super.initState();
  }

  String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('MM-dd-yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Lihat Postingan',
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Consumer<GetPostByUserProvider>(
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
              if (provider.postResponse!.data.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Oops, belum ada postingan',
                            style: AppStyle.body1()),
                      ],
                    ),
                  ),
                );
              } else {
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: provider.postResponse!.data.length,
                    itemBuilder: (context, index) {
                      var posts = provider.postResponse!.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: IntrinsicHeight(
                          child: LeftAlignedColumn(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ClipOval(
                                      child: Image.network(
                                        posts.user.image ??
                                            'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ).rightPadded16(),
                                  LeftAlignedColumn(
                                    children: [
                                      Row(
                                        children: [
                                          LimitedBox(
                                            maxWidth: 200,
                                            child: Text(
                                              posts.user.name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle.body1(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (posts.user.university != null)
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
                                              posts.user.university ?? '',
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
                                        convertDateFormat(
                                          posts.createdAt.toIso8601String(),
                                        ),
                                        style: AppStyle.body3(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Hapus Postingan'),
                                            content: const Text(
                                                'Kamu yakin ingin menghapus postingan ini?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Tidak'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Yakin'),
                                                onPressed: () {
                                                  _deletePostsProvider
                                                      .doDeletePostss(
                                                          id: posts.id
                                                              .toString());
                                                  _getPostByUserProvider
                                                      .doGetPostByUsers();
                                                  Navigator.of(context).pop();
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Berhasil hapus postingan');
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.more_vert,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ).bottomPadded24(),
                              Text(
                                posts.description,
                                style: AppStyle.body2(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ).bottomPadded12(),
                              if (posts.attachment != null)
                                IntrinsicHeight(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Image.network(
                                      posts.attachment.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ).bottomPadded16(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showCommentBottomSheet(
                                          id: posts.id,
                                          comment: posts.comments);
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.comment_outlined,
                                          size: 30,
                                          color: Colors.black,
                                        ).rightPadded12(),
                                        Text(
                                          'Comment',
                                          style: AppStyle.body2(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${posts.comments.length} Comment',
                                    style: AppStyle.body2(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showCommentBottomSheet({
    required int id,
    required List<Comment>? comment,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: DraggableScrollableSheet(
                  maxChildSize: 1,
                  initialChildSize: 1,
                  minChildSize: 0.3,
                  builder: (context, scrollController) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 5,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Comment',
                                  style: AppStyle.subtitle4(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: comment == null || comment.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 200),
                                    child: Center(
                                      child: Text(
                                        'Belum ada komentar',
                                        style: AppStyle.subtitle4(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: comment.length,
                                    itemBuilder: (context, index) {
                                      var comments = comment[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: ClipOval(
                                                child: Image.network(
                                                  comments.user.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 290,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD0CECE),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 10, 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        LimitedBox(
                                                          maxWidth: 90,
                                                          child: Text(
                                                            comments.user.name!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                AppStyle.body1(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        if (comments.user
                                                                .university !=
                                                            null)
                                                          Text(
                                                            ' - ',
                                                            style:
                                                                AppStyle.body1(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        LimitedBox(
                                                          maxWidth: 150,
                                                          child: Text(
                                                            comments.user
                                                                    .university ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                AppStyle.body1(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Laporkan Comment'),
                                                                  content:
                                                                      const Text(
                                                                          'Kamu yakin ingin melaporkan comment ini?'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'Tidak'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'Yakin'),
                                                                      onPressed:
                                                                          () {
                                                                        // Add your reporting logic here
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        // For example, you might want to show a SnackBar
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          const SnackBar(
                                                                              content: Text('Post reported')),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: const Icon(
                                                            Icons.more_vert,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      comments.description,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: AppStyle.body3(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).bottomPadded16();
                                    },
                                  ),
                          ),
                        ),
                        Consumer<GetUserProvider>(
                          builder: (_, provider, __) {
                            if (provider.isLoading) {
                              return const LoadingShimmer(
                                height: 30,
                                width: double.infinity,
                              );
                            }
                            if (provider.isLoaded) {
                              if (provider.userResponse!.data.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Oops', style: AppStyle.body1()),
                                    ],
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.userResponse!.data.length,
                                  itemBuilder: (context, index) {
                                    var user =
                                        provider.userResponse!.data[index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        Container(
                                          height: 45,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffD0CECE),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: TextField(
                                              controller: commentController,
                                              decoration: InputDecoration(
                                                hintText: 'Write a comment',
                                                hintStyle: AppStyle.body2(
                                                    color: Colors.black),
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                              style: AppStyle.body2(
                                                  color: Colors.black),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ).rightPadded10(),
                                        GestureDetector(
                                          onTap: () async {
                                            String newCommentText =
                                                commentController.text;
                                            await _commentProvider.doComments(
                                                postId: id,
                                                description: newCommentText);

                                            commentController.clear();

                                            Comment newComment = Comment(
                                              id: id,
                                              description: newCommentText,
                                              user: user,
                                              createdAt: DateTime.now(),
                                              updatedAt: DateTime.now(),
                                            );

                                            setState(() {
                                              comment!.add(newComment);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            size: 30,
                                            color: Colors.purple,
                                          ),
                                        ).rightPadded16(),
                                      ],
                                    )
                                        .bottomPadded16()
                                        .leftPadded16()
                                        .rightPadded16();
                                  },
                                );
                              }
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
