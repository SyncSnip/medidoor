import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/pages/something_went_wrong.dart';
import 'package:user_app/common/ui_functions/ui_functions.dart';
import 'package:user_app/common/widgets/loading.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:user_app/redirecting_page.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final AuthBloc _authBloc = AuthBloc();
  String otp = '';
  final List<TextEditingController> _emailOtpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<TextEditingController> _mobileOtpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _emailFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  final List<FocusNode> _mobileFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _emailOtpControllers) {
      controller.dispose();
    }
    for (var controller in _mobileOtpControllers) {
      controller.dispose();
    }
    for (var node in _emailFocusNodes) {
      node.dispose();
    }
    for (var node in _mobileFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _authBloc.add(AuthVerifyEmailOtpNormalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthVerifyEmailOtpSuccessState) {
            context.pushReplacement(const RedirectingPage());
          } else if (state is AuthVerifyEmailOtpFailureState) {
            context.push(const SomethingWentWrong());
          } else if (state is AuthUserNotFoundOtpState) {
            errorPopup(ctx: context, head: 'User Not Found');

            _authBloc.add(AuthVerifyEmailOtpNormalEvent());
          }
        },
        builder: (context, state) {
          if (state is AuthVerifyEmailOtpLoadingState) {
            return const Loading();
          } else if (state is AuthVerifyEmailOtpInitialState) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.green,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'An OTP is sent to the entered Email address.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => _buildOTPField(
                        _emailOtpControllers[index],
                        _emailFocusNodes[index],
                        index,
                        true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // const Text(
                  //   'An OTP is sent to the entered Mobile number.',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //     6,
                  //     (index) => _buildOTPField(
                  //       _mobileOtpControllers[index],
                  //       _mobileFocusNodes[index],
                  //       index,
                  //       false,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        otp = _emailOtpControllers
                            .map((controller) => controller.text)
                            .join();

                        log(otp);

                        if (otp.length == 6) {
                          _authBloc.add(AuthVerifyEmailOtpEvent(otp: otp));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOTPField(
    TextEditingController controller,
    FocusNode focusNode,
    int index,
    bool isEmail,
  ) {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          counterText: '',
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1) {
            if (index < 5) {
              if (isEmail) {
                _emailFocusNodes[index + 1].requestFocus();
              } else {
                _mobileFocusNodes[index + 1].requestFocus();
              }
            }
          } else if (value.isEmpty && index > 0) {
            if (isEmail) {
              _emailFocusNodes[index - 1].requestFocus();
            } else {
              _mobileFocusNodes[index - 1].requestFocus();
            }
          }
        },
      ),
    );
  }
}
