import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/widgets/loading.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:user_app/redirecting_page.dart';

import 'forgetmail_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthBloc _authBloc = AuthBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _checkBox = false;

  @override
  void initState() {
    super.initState();
    _authBloc.add(AuthSignInNormalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 190, 234, 237),
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is AuthSignInSuccessState) {
              context.push(const RedirectingPage());
              return;
            } else if (state is AuthSignInNotVerifiedUserState) {
              const snackBar = SnackBar(
                content: Text('You are not a verified user'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              _authBloc.add(AuthSignInNormalEvent());
              return;
            } else if (state is AuthSignInFailureState) {
              const snackBar = SnackBar(
                content: Text('Invalid credentials'),
              );
              _passController.clear();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              _authBloc.add(AuthSignInNormalEvent());
              return;
            }
          },
          builder: (context, state) {
            if (state is AuthSignInLoadingState) {
              return const Loading();
            } else if (state is AuthSignInInitialState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 190, 234, 237),
                      ),
                      child: Image.asset(
                        'assets/images/authimg.png', // Add your image asset here
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome Back!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Login to your account',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            20.ah,
                            const Text(
                              "Enter Email*",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            10.ah,
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            20.ah,
                            const Text(
                              "Enter Mobile No.*",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            10.ah,
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: TextFormField(
                                  controller: _mobileController,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter mobile number';
                                  //   } else if (value.length != 10) {
                                  //     return 'Mobile number must be 10 digits';
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                ),
                              ),
                            ),
                            20.ah,
                            const Text(
                              "Enter Password*",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            10.ah,
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: TextFormField(
                                  obscureText: _isPasswordVisible,
                                  controller: _passController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      child: Icon(_isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            10.ah,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: _checkBox,
                                        onChanged: (value) {
                                          setState(() {
                                            _checkBox = !_checkBox;
                                          });
                                        }),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordPage()),
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _authBloc.add(AuthSignInEvent(
                                        email:
                                            _emailController.text.toLowerCase(),
                                        password: _passController.text));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 90, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        width: 0.8, color: Colors.black),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(1),
                                        // offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  _authBloc.add(AuthSignInNormalEvent());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RedirectingPage()),
                                  );
                                },
                                child: Text(
                                  'New user? Signup here.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[900],
                                    // decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Loading();
          },
        ),
      ),
    );
  }
}
