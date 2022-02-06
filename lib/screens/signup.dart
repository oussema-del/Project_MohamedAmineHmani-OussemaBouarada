import 'package:flutter/material.dart';
import 'package:ihm/constants/fire_base_constants.dart';
import 'package:ihm/styles/app_colors.dart';
import 'package:ihm/screens/login.dart';
import 'package:ihm/widgets/local_widgets/custom_button.dart';
import 'package:ihm/widgets/local_widgets/custom_formfield.dart';
import 'package:ihm/widgets/local_widgets/custom_header.dart';
import 'package:ihm/widgets/local_widgets/custom_richtext.dart';
import 'package:ihm/widgets/local_widgets/google_sign%20in%20button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = true;
  String get userName => _userName.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColors.yellowtaxi,
              ),
              CustomHeader(
                  text: 'Sign Up.',
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.whiteshade,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.09),
                        child: Image.asset("assets/images/logo.png"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        headingText: "UserName",
                        hintText: "username",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        controller: _userName,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        headingText: "Email",
                        hintText: "Email",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        controller: _passwordController,
                        headingText: "Password",
                        hintText: "At least 8 Character",
                        obsecureText: !_passwordVisible,
                        suffixIcon: IconButton(
                            icon: Icon(
                              !_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AuthButton(
                        onTap: () {},
                        text: 'Sign Up',
                      ),
                      AuthButton(
                          onTap: () {
                            authController.signInWithGoogle();
                          },
                          text: "google"),
                      CustomRichText(
                        discription: 'Already Have an account? ',
                        text: 'Log In here',
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
