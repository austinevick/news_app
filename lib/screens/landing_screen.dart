import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            Text(
              'Get the Latest and Updated Articles Easily with Us',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
