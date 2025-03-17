import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/resources/theme/app_style.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/features/register/provider/register_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late RegisterProvider _registerProvider;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  @override
  void initState() {
    _registerProvider = Provider.of<RegisterProvider>(context, listen: false);
    super.initState();
    passwordController.addListener(_checkPassword);
    confirmPasswordController.addListener(_checkConfirmPassword);
  }

  void _checkPassword() {
    setState(() {
      isPasswordValid = passwordController.text.length >= 8;
    });
  }

  void _checkConfirmPassword() {
    setState(() {
      isConfirmPasswordValid =
          confirmPasswordController.text == passwordController.text;
    });
  }

  @override
  void dispose() {
    passwordController.removeListener(_checkPassword);
    passwordController.dispose();
    namaController.dispose();
    dateController.dispose();
    usernameController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff2e7aa5),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Center(
          child: Column(
            children: [
              Text(
                'Registration',
                style: AppStyle.subtitle1(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ).bottomPadded(50),
              _buildTextField(
                controller: namaController,
                hintText: 'Name',
                obscureText: false,
              ).bottomPadded12(),
              _buildTextField(
                controller: dateController,
                hintText: 'Tanggal Lahir (cth. 01/02/2003)',
                obscureText: false,
              ).bottomPadded12(),
              _buildTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ).bottomPadded12(),
              _buildTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ).bottomPadded12(),
              _buildPasswordField(
                controller: passwordController,
                hintText: 'Password',
                isPasswordValid: isPasswordValid,
                isPasswordVisible: isPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ).bottomPadded12(),
              _buildConfirmPasswordField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                isConfirmPasswordValid: isConfirmPasswordValid,
                isPasswordVisible: isConfirmPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  });
                },
              ).bottomPadded(30),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (namaController.text.isEmpty ||
                        usernameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Isi semua field');
                    } else {
                      if (!isConfirmPasswordValid) {
                        Fluttertoast.showToast(
                            msg: 'Password Confirmation harus sama');
                      } else if (!isPasswordValid) {
                        Fluttertoast.showToast(
                            msg: 'Password harus 8 karakter atau lebih');
                      } else {
                        await _registerProvider.doRegister(
                          context: context,
                          name: namaController.text,
                          dateOfBirth: dateController.text,
                          username: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation: confirmPasswordController.text,
                        );
                      }
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
                        'Sign Up',
                        style: AppStyle.subtitle4(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ).bottomPadded20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppStyle.body1(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ).rightPadded12(),
                  GestureDetector(
                    onTap: () {
                      context.router.replace(const LoginRoute());
                    },
                    child: Text(
                      'Sign In',
                      style: AppStyle.body1(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
  }) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyle.body1(),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
        validator: (input) => input == '' ? "Don't empty" : null,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isPasswordValid,
    required bool isPasswordVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyle.body1(),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPasswordValid ? Icons.check_circle : Icons.cancel,
                color: isPasswordValid ? Colors.green : Colors.red,
              ),
              IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onVisibilityToggle,
              ),
            ],
          ),
        ),
        validator: (input) => input == '' ? "Don't empty" : null,
      ),
    );
  }

  Widget _buildConfirmPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isConfirmPasswordValid,
    required bool isPasswordVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyle.body1(),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isConfirmPasswordValid ? Icons.check_circle : Icons.cancel,
                color: isConfirmPasswordValid ? Colors.green : Colors.red,
              ),
              IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onVisibilityToggle,
              ),
            ],
          ),
        ),
        validator: (input) => input == '' ? "Don't empty" : null,
      ),
    );
  }
}
