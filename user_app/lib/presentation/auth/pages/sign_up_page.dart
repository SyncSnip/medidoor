import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/common/widgets/loading.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:user_app/presentation/auth/pages/otp_screen_sign_up.dart';
import 'package:user_app/presentation/auth/pages/sign_in_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthBloc _authBloc = AuthBloc();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isPasswordValid = true;

  void _validatePassword(String value) {
    setState(() {
      // _isPasswordValid = value.length >= 4 &&
      //     RegExp(r'[0-9]').hasMatch(value) &&
      //     RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthSignUpSuccessState) {
            log('going to otp page');
            context.push(const OtpVerificationPage());
          } else if (state is AuthSignUpUserExistState) {
            const snackBar = SnackBar(
              content: Text('User is already exists'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            _authBloc.add(AuthSignInNormalEvent());
            return;
          }
        },
        builder: (context, state) {
          if (state is AuthSignUpLoadingState) {
            return const Loading();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'New to Medidoor?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Create your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  // _buildTextField(),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Mobile No.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: 'Set Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: _isPasswordValid
                          ? null
                          : 'Must be 8 or more characters and contain at least 1 number\n and 1 special character.',
                    ),
                    obscureText: _isPasswordVisible,
                    onChanged: _validatePassword,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text('Remember me'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // context.push(const RedirectingPage());
                        // if (_formKey.currentState!.validate()) {
                        _authBloc.add(AuthSignUpEvent(
                            email: _emailController.text.toLowerCase(),
                            password: _passwordController.text,
                            name: _nameController.text));
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                        );
                      },
                      child: const Text(
                        'Already a user? Login here.',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle Google signup
                      },
                      icon: const Icon(Icons.g_mobiledata),
                      label: const Text('with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
