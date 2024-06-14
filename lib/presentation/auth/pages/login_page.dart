import 'package:absensi_app/core/core.dart';
import 'package:absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:absensi_app/data/models/response/auth_response_model.dart';
import 'package:absensi_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:absensi_app/presentation/home/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                controller: passwordController,
                label: 'Password',
                showLabel: false,
                obscureText: !isShowPassword,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    Assets.icons.password.path,
                    height: 20,
                    width: 20,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isShowPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                ),
              ),
          const SpaceHeight(80.0),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (data) {
                  AuthLocalDatasource().saveAuthData(data);
                  context.pushReplacement(const MainPage());
                },
                error: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: AppColors.red,
                    ),
                  );
                },
              );
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        // context.pushReplacement(const MainPage());
                        context.read<LoginBloc>().add(LoginEvent.login(
                            emailController.text, passwordController.text));
                      },
                      label: 'Sign In',
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
