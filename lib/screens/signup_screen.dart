import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/auth_provider.dart';
import 'package:news_app/screens/bottom_navigation_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/widget/custom_button.dart';
import 'package:news_app/widget/custom_textfield.dart';

import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscuredText = true;
  bool isLoading = false;
  bool isGLoading = false;

  bool isChecked = false;

  Future signUp() async {
    try {
      setState(() => isLoading = true);
      final user = await AuthProvider.signUp(
          emailController.text, passwordController.text);

      if (user.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const BottomNavigationScreen()),
            (r) => false);
      }
      setState(() => isLoading = false);
      print(user.user!.email);
      return user;
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

  Future signUpWithGoogle() async {
    try {
      setState(() => isGLoading = true);
      final user = await AuthProvider.signInWithGoogle();

      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const BottomNavigationScreen()),
            (r) => false);
      }
      setState(() => isGLoading = false);
      print(user!.email);
      return user;
    } on FirebaseAuthException catch (e) {
      setState(() => isGLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

  SnackBar snackBar = const SnackBar(content: Text('Something went wrong'));
  SnackBar checkSnackBar = const SnackBar(
      content: Text('You must agree with our terms and privacy'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 22),
                  CustomButton(
                      onPressed: () => signUpWithGoogle(),
                      width: double.infinity,
                      child: getGIsLoadingState),
                  const SizedBox(height: 15),
                  const Divider(thickness: 3),
                  const SizedBox(height: 15),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: nameController,
                    hintText: 'John Doe',
                    validator: (value) =>
                        value!.isEmpty ? 'enter your name' : null,
                  ),
                  const SizedBox(height: 18),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    validator: (value) =>
                        !value!.contains('@') ? 'Invalid email' : null,
                    controller: emailController,
                    hintText: 'example@gmail.com',
                  ),
                  const SizedBox(height: 18),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: passwordController,
                    obscureText: true,
                    hintText: 'at least 8 characters',
                    validator: (value) =>
                        value!.length < 8 ? 'Password too weak' : null,
                  ),
                  // Row(
                  //   children: List.generate(
                  //       4,
                  //       (index) => Expanded(
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Container(
                  //                 height: 4,
                  //                 color: Colors.grey.shade300,
                  //               ),
                  //             ),
                  //           )),
                  // ),
                  Row(
                    children: [
                      Checkbox(
                          shape: const StadiumBorder(),
                          value: isChecked,
                          onChanged: (v) => setState(() => isChecked = v!)),
                      const Text('I agree with'),
                      const Text(
                        'Terms ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      const Text('and '),
                      const Text(
                        'Privacy',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  const SizedBox(height: 18),
                  CustomButton(
                    width: double.infinity,
                    child: getIsLoadingState,
                    color: Colors.blue,
                    onPressed: () {
                      if (!isChecked) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(checkSnackBar);
                      }
                      if (formKey.currentState!.validate()) signUp();
                    },
                  ),
                  const SizedBox(height: 8),
                  const Divider(thickness: 3),
                  const SizedBox(height: 18),
                  const Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const SignInScreen()));
                      },
                      child: const Text('Log in')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get getIsLoadingState => isLoading
      ? const Center(
          child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white)))
      : const Text(
          'Sign up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        );
  Widget get getGIsLoadingState => isGLoading
      ? const Center(
          child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.blue)))
      : const Text(
          'Sign up with Google',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
        );
}
