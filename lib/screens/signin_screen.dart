import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/auth_provider.dart';
import 'package:news_app/screens/bottom_navigation_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/signup_screen.dart';
import 'package:news_app/widget/custom_button.dart';
import 'package:news_app/widget/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isGLoading = false;

  bool obscuredText = true;

  Future signIn() async {
    try {
      setState(() => isLoading = true);
      final user = await AuthProvider.signIn(
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

  Future signInWithGoogle() async {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Log In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.clear))
                    ],
                  ),
                  const SizedBox(height: 22),
                  CustomButton(
                      onPressed: () => signInWithGoogle(),
                      width: double.infinity,
                      child: getGIsLoadingState),
                  const SizedBox(height: 15),
                  const Divider(thickness: 3),
                  const SizedBox(height: 15),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    controller: emailController,
                    hintText: 'example@gmail.com',
                    validator: (value) =>
                        !value!.contains('@') ? 'invalid email' : null,
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
                    validator: (value) =>
                        value!.length < 8 ? 'Password too weak' : null,
                    hintText: 'at least 8 characters',
                  ),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (v) {}),
                      const Text('Remember me')
                    ],
                  ),
                  const SizedBox(height: 18),
                  CustomButton(
                    width: double.infinity,
                    child: getIsLoadingState,
                    color: Colors.blue,
                    onPressed: () {
                      if (formKey.currentState!.validate()) signIn();
                    },
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text('Forgot password?')),
                  const Divider(thickness: 3),
                  const SizedBox(height: 18),
                  const Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const SignUpScreen()));
                      },
                      child: const Text('Sign up')),
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
          'Log in',
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
          'Log in with Google',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
        );
}
