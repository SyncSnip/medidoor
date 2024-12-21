import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/widgets/loading.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:user_app/presentation/auth/pages/otp_screen_sign_up.dart';
import 'package:user_app/presentation/auth/pages/sign_in_page.dart';

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
  final TextEditingController _mobileController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isPasswordValid = true;

  void _validatePassword(String value) {
    setState(() {
      _isPasswordValid = value.length >= 8 &&
          RegExp(r'[0-9]').hasMatch(value) &&
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _authBloc.add(AuthSignUpNormalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 190, 234, 237),
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is AuthSignUpSuccessState) {
              context.pushReplacement(const OtpVerificationPage());
            } else if (state is AuthSignUpFailureState) {
              _authBloc.add(AuthSignUpNormalEvent());
            }
          },
          builder: (context, state) {
            if (state is AuthSignUpLoadingState) {
              return const Loading();
            } else if (state is AuthSignUpInitialState) {
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
                        'assets/images/authimg.png',
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
                              'New to Medidoor?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Create your account',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            20.ah,
                            const Text(
                              "Enter Name*",
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
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 8),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter mobile number';
                                    } else if (value.length != 10) {
                                      return 'Mobile number must be 10 digits';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 8),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter valid email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 8),
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
                              "Set Password*",
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
                                  controller: _passwordController,
                                  validator: (value) {
                                    // if (value == null || value.isEmpty) {
                                    //   return 'Please enter password';
                                    // } else if (!_isPasswordValid) {
                                    //   return 'Password must be 8 or more characters with at least 1 number and 1 special character';
                                    // }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 8),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusColor: Colors.transparent,
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
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  obscureText: _isPasswordVisible,
                                  onChanged: _validatePassword,
                                ),
                              ),
                            ),
                            10.ah,
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (value) {}),
                                const Text('Remember me'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _authBloc.add(AuthSignUpEvent(
                                        email:
                                            _emailController.text.toLowerCase(),
                                        password: _passwordController.text,
                                        name: _nameController.text));
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
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'Sign Up',
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInPage()),
                                  );
                                },
                                child: Text(
                                  'Already a user? Login here.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                            ),
                            20.ah,
                            // const Center(
                            //   child: Text(
                            //     "Or",
                            //     style: TextStyle(
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w700,
                            //       color: Colors.black87,
                            //     ),
                            //   ),
                            // ),
                            // 20.ah,
                            // Center(
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       // Handle Google signup
                            //     },
                            //     child: Container(
                            //       padding: const EdgeInsets.symmetric(
                            //         horizontal: 50,
                            //         vertical: 8,
                            //       ),
                            //       decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(30),
                            //         border: Border.all(
                            //           color: const Color.fromARGB(255, 196, 195, 195),
                            //           width: 2,
                            //         ),
                            //         boxShadow: [
                            //           BoxShadow(
                            //             color: Colors.grey.withOpacity(0.1),
                            //             spreadRadius: 1,
                            //             blurRadius: 4,
                            //             offset: const Offset(0, 2),
                            //           ),
                            //         ],
                            //       ),
                            //       child: Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           SvgPicture.asset(
                            //             'assets/icons/google.svg',
                            //             height: 24,
                            //             width: 24,
                            //           ),
                            //           const SizedBox(width: 12),
                            //           const Text(
                            //             'with Google',
                            //             style: TextStyle(
                            //               color: Colors.black87,
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.w700,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
