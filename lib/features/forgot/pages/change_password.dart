import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/forgot/provider/forgot_password_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  final String email;
  const ChangePasswordPage({super.key, required this.email});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();

  late ForgotPasswordProvider _forgotPasswordProvider;

  @override
  void initState() {
    _forgotPasswordProvider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
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
                Text(
                  'Ganti Password',
                  style: AppStyle.subtitle1(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ).bottomPadded(10),
                Text(
                  'Masukan otp yang dikirim melalui email, dan isi password yang baru',
                  style: AppStyle.body1(
                    color: Colors.black,
                  ),
                ).bottomPadded(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'OTP',
                          style: AppStyle.body1(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 290,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        obscureText: false,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'OTP',
                          hintStyle: AppStyle.body1(),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (input) => input == '' ? "" : null,
                      ),
                    )
                  ],
                ).bottomPadded16(),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: AppStyle.body1(),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    validator: (input) => input == '' ? "" : null,
                  ),
                ).bottomPadded16(),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordConfirmation,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Password Confirmation',
                      hintStyle: AppStyle.body1(),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    validator: (input) => input == '' ? "" : null,
                  ),
                ).bottomPadded(30),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (passwordController.text.isEmpty ||
                          passwordConfirmation.text.isEmpty ||
                          otpController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Isi semua field');
                      } else if (passwordConfirmation.text !=
                          passwordController.text) {
                        Fluttertoast.showToast(msg: 'Password harus sama');
                      } else {
                        _forgotPasswordProvider.doForgotPasswords(
                            context: context,
                            emailUser: widget.email,
                            otp: int.parse(otpController.text),
                            password: passwordController.text,
                            passwordConfirmation: passwordConfirmation.text);
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
