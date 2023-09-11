import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Enumeration to represent the authentication modes
enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = '/auth-screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup; // Current authentication mode
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to sign up the user
  void signUp() {
    authService.signUpUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  // Function to sign in the user
  void signIn() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                // Radio buttons for selecting the authentication mode
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    'Create Account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    value: Auth.signup,
                    activeColor: GlobalVariables.secondaryColor,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    },
                  ),
                ),
                // Form for signing up
                if (_auth == Auth.signup)
                  Container(
                    padding: EdgeInsets.all(8.w),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Name',
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          CustomButton(
                            onPressed: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUp();
                              }
                            },
                            text: 'Sign Up',
                          )
                        ],
                      ),
                    ),
                  ),
                // Radio button for signing in
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    'Sign-In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    value: Auth.signin,
                    activeColor: GlobalVariables.secondaryColor,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    },
                  ),
                ),
                // Form for signing in
                if (_auth == Auth.signin)
                  Container(
                    padding: EdgeInsets.all(8.w),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          CustomButton(
                            onPressed: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signIn();
                              }
                            },
                            text: 'Sign In',
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
