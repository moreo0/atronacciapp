import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/profile/provider/create_reminder_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:univs/features/profile/provider/get_reminder_provider.dart';

@RoutePage()
class CreateSetReminderPage extends StatefulWidget {
  const CreateSetReminderPage({super.key});

  @override
  State<CreateSetReminderPage> createState() => _CreateSetReminderPageState();
}

class _CreateSetReminderPageState extends State<CreateSetReminderPage> {
  final TextEditingController _dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime? selectedDate;
  final formKey = GlobalKey<FormState>();

  late CreateReminderProvider _createReminderProvider;
  late GetReminderProvider _getReminderProvider;

  @override
  void initState() {
    super.initState();
    _createReminderProvider =
        Provider.of<CreateReminderProvider>(context, listen: false);
    _getReminderProvider =
        Provider.of<GetReminderProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: AppStyle.subtitle4(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  'Task',
                  style: AppStyle.subtitle4(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).bottomPadded12(),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffD0CECE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Ingatkan saya untuk...',
                        hintStyle: AppStyle.body2(color: Colors.black),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: AppStyle.body2(color: Colors.black),
                      // controller: searchC,
                      onChanged: (value) {},
                      validator: (input) => input == '' ? "Don't empty" : null,
                    ),
                  ),
                ).bottomPadded12(),
                Text(
                  'Jam',
                  style: AppStyle.subtitle4(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).bottomPadded12(),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffD0CECE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(
                        hintText: 'Masukan Jam (cth: 13:00)',
                        hintStyle: AppStyle.body2(color: Colors.black),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: AppStyle.body2(color: Colors.black),
                      // controller: searchC,
                      onChanged: (value) {},
                      validator: (input) => input == '' ? "Don't empty" : null,
                    ),
                  ),
                ).bottomPadded12(),
                Text(
                  'Tanggal',
                  style: AppStyle.subtitle4(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).bottomPadded12(),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffD0CECE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        hintText: 'dd/mm/yy',
                        hintStyle: AppStyle.body2(color: Colors.black),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          icon: const Icon(
                            Icons.calendar_today,
                          ),
                        ),
                      ),
                      style: AppStyle.body2(color: Colors.black),
                      // controller: searchC,
                      onChanged: (value) {},
                      validator: (input) => input == '' ? "Don't empty" : null,
                    ),
                  ),
                ).bottomPadded16(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(100, 0, 100, 40),
        child: GestureDetector(
          onTap: () async {
            if (formKey.currentState!.validate()) {
              await _createReminderProvider.doCreateReminders(
                context: context,
                title: titleController.text,
                date: _dateController.text,
                time: timeController.text,
              );
              _getReminderProvider.doGetReminders();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Format the date to "yyyy-MM-dd" format
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }
}
