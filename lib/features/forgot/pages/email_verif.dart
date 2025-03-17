import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/forgot/provider/email_verif_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EmailVerifPage extends StatefulWidget {
  const EmailVerifPage({super.key});

  @override
  State<EmailVerifPage> createState() => _EmailVerifPageState();
}

class _EmailVerifPageState extends State<EmailVerifPage> {
  TextEditingController emailController = TextEditingController();

  late VerifEmailProvider _verifEmailProvider;

  @override
  void initState() {
    _verifEmailProvider =
        Provider.of<VerifEmailProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A79AC),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.router.replace(const LoginRoute());
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ).bottomPadded20(),
                Text(
                  'Forgot Password?',
                  style: AppStyle.subtitle1(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).bottomPadded(10),
                Text(
                  'Masukan email address yang kamu daftarkan sebelumnya',
                  style: AppStyle.body1(
                    color: Colors.black,
                  ),
                ).bottomPadded(50),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    obscureText: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: AppStyle.body1(),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    validator: (input) => input == '' ? "" : null,
                  ),
                ).bottomPadded24(),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (emailController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Isi email terlebih dahulu');
                      } else {
                        _verifEmailProvider.doVerifEmails(
                            context: context, emailUser: emailController.text);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: AppStyle.subtitle4(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ).bottomPadded24(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
