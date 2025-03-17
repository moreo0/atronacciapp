import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/profile/provider/delete_reminder_provider.dart';
import 'package:univs/features/profile/provider/get_reminder_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

@RoutePage()
class SetReminderPage extends StatefulWidget {
  const SetReminderPage({super.key});

  @override
  State<SetReminderPage> createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  late GetReminderProvider _getReminderProvider;
  late DeleteReminderProvider _deleteReminderProvider;

  String convertDateFormat(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('MM-dd-yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getReminderProvider =
          Provider.of<GetReminderProvider>(context, listen: false);
      _deleteReminderProvider =
          Provider.of<DeleteReminderProvider>(context, listen: false);
      _getReminderProvider.doGetReminders();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Set Reminder',
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              'Task',
              style: AppStyle.subtitle4(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ).bottomPadded16(),
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
                            Text('Oops, belum ada reminder',
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
                          height: 125,
                          width: 300,
                          decoration: BoxDecoration(
                            color: const Color(0xffD0CECE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: LeftAlignedColumn(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      reminder.title,
                                      style: AppStyle.body1(
                                          fontWeight: FontWeight.bold),
                                    ).bottomPadded4(),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          _deleteReminderProvider
                                              .doDeleteReminders(
                                            id: reminder.id.toString(),
                                          );
                                          _getReminderProvider.doGetReminders();
                                        },
                                        child: const Icon(Icons.delete))
                                  ],
                                ),
                                Text(
                                  'Deadline :',
                                  style: AppStyle.body1(
                                      fontWeight: FontWeight.bold),
                                ).bottomPadded4(),
                                Row(
                                  children: [
                                    Text(
                                      'Tanggal',
                                      style: AppStyle.body1(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      convertDateFormat(
                                          reminder.date.toIso8601String()),
                                      style: AppStyle.body1(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ).bottomPadded4(),
                                Row(
                                  children: [
                                    Text(
                                      'Jam',
                                      style: AppStyle.body1(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      reminder.time,
                                      style: AppStyle.body1(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
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
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(100, 0, 100, 20),
        child: GestureDetector(
          onTap: () {
            context.router.push(const CreateSetReminderRoute());
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
                'Add Task',
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
