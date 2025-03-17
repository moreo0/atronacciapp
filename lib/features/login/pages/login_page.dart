import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/assets.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/login/provider/login_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LoginProvider _loginProvider;

  @override
  void initState() {
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
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
                ).bottomPadded12(),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: AppStyle.body1(),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    validator: (input) => input == '' ? "" : null,
                  ),
                ).bottomPadded12(),
                Row(
                  children: [
                    Text(
                      'Forgot Password?',
                      style: AppStyle.body1(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ).rightPadded12(),
                    GestureDetector(
                      onTap: () {
                        context.router.replace(const EmailVerifRoute());
                      },
                      child: Text(
                        'Click here',
                        style: AppStyle.body1(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).bottomPadded(26),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Isi semua field');
                      } else {
                        _loginProvider.doLogin(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                        );
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
                          'Log In',
                          style: AppStyle.subtitle4(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ).bottomPadded24(),
                Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Image.asset(
                        Assets.imgGoogle,
                      ),
                    ),
                  ),
                ).bottomPadded(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppStyle.body1(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ).rightPadded12(),
                    GestureDetector(
                      onTap: () {
                        context.router.replace(const RegisterRoute());
                      },
                      child: Text(
                        'Sign Up',
                        style: AppStyle.body1(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).bottomPadded(26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
