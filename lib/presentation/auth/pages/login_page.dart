import 'package:absensi_app/core/core.dart';
import 'package:absensi_app/presentation/home/pages/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          const SpaceHeight(50.0),
          Padding(
            padding: const EdgeInsets.all(85.0),
            child: Assets.images.logo.image(),
          ),
          const SpaceHeight(30.0),
          CustomTextField(
            showLabel: false,
            controller: emailController,
            label: 'Email Address',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.icons.email.svg(),
            ),
          ),
          const SpaceHeight(18.0),
          CustomTextField(
            showLabel: false,
            controller: passwordController,
            label: 'Password',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.icons.password.svg(),
            ),
            obscureText: true,
          ),
          const SpaceHeight(80.0),
          Button.filled(
            onPressed: () {
              context.pushReplacement(const MainPage());
            },
            label: 'Sign In',
          ),
        ],
      ),
    );
  }
}