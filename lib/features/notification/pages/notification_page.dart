import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/profile/provider/get_reminder_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late GetReminderProvider _getReminderProvider;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getReminderProvider =
          Provider.of<GetReminderProvider>(context, listen: false);
      _getReminderProvider.doGetReminders();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification',
                style: AppStyle.subtitle1(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ).bottomPadded20(),
              Text(
                'Terbaru',
                style: AppStyle.subtitle4(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ).bottomPadded20(),
              Consumer<GetReminderProvider>(
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
                    if (provider.filteredReminder.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Oops, belum ada notification',
                                  style: AppStyle.body1()),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.filteredReminder.length,
                        itemBuilder: (context, index) {
                          var reminder = provider.filteredReminder[index];
                          return Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff97D3FF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  reminder.title,
                                  style: AppStyle.subtitle4(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ).leftPadded16(),
                                const Spacer(),
                                Text(
                                  reminder.time,
                                  style: AppStyle.subtitle4(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ).rightPadded16()
                              ],
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
    );
  }
}
