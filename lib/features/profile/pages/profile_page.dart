import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/resources/network/http_service.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/core/resources/injector/di.dart' as di;
import 'package:univs/features/profile/provider/get_user_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late GetUserProvider _getUserProvider;

  String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getUserProvider = Provider.of<GetUserProvider>(context, listen: false);
      _getUserProvider.doGetUsers();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Consumer<GetUserProvider>(
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
                if (provider.userResponse!.data.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Oops, belum ada user', style: AppStyle.body1()),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: provider.userResponse!.data.length,
                    itemBuilder: (context, index) {
                      var users = provider.userResponse!.data[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: ClipOval(
                              child: Image.network(
                                users.image ??
                                    'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ).topPadded30().bottomPadded20(),
                          LimitedBox(
                            maxWidth: 300,
                            child: Text(
                              users.name!,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.subtitle3(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ).bottomPadded20(),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.router.push(
                                EditProfileRoute(
                                  name: users.name!,
                                  dateOfBirth: convertDateFormat(
                                    users.dateOfBirth!.toIso8601String(),
                                  ),
                                  university: users.university ?? '',
                                  gender: users.gender ?? '',
                                  imageUrl: users.image ??
                                      'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg',
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xffD0CECE),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Edit Profile',
                                  style: AppStyle.body1(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ).bottomPadded12(),
                          GestureDetector(
                            onTap: () {
                              context.router.push(const SetReminderRoute());
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xffD0CECE),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Set Reminder',
                                  style: AppStyle.body1(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ).bottomPadded12(),
                          GestureDetector(
                            onTap: () {
                              context.router.push(const LihatPostinganRoute());
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xffD0CECE),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Lihat Postingan',
                                  style: AppStyle.body1(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ).bottomPadded(30),
                          const Divider(
                            height: 1,
                            color: Color(0xffD0CECE),
                          ).bottomPadded24(),
                          Row(
                            children: [
                              const Icon(Icons.school).rightPadded16(),
                              LimitedBox(
                                maxWidth: 250,
                                child: Text(
                                  users.university ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.subtitle4(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ).leftPadded(20).rightPadded(20).bottomPadded16(),
                          Row(
                            children: [
                              const Icon(Icons.male).rightPadded16(),
                              Text(
                                users.gender ?? '-',
                                style: AppStyle.subtitle4(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ).leftPadded(20).rightPadded(20).bottomPadded16(),
                          Row(
                            children: [
                              const Icon(Icons.cake).rightPadded16(),
                              Text(
                                convertDateFormat(
                                    users.dateOfBirth!.toIso8601String()),
                                style: AppStyle.subtitle4(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ).leftPadded(20).rightPadded(20).bottomPadded24(),
                          const Divider(
                            height: 1,
                            color: Color(0xffD0CECE),
                          ).bottomPadded24(),
                          GestureDetector(
                            onTap: () async {
                              di.sl<HttpService>().removeToken();
                              await storage.clearAllData();
                              // ignore: use_build_context_synchronously
                              context.router.replace(const LoginRoute());
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xffFF4D4D),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Logout',
                                  style: AppStyle.body1(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ).bottomPadded12(),
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
    );
  }
}
