import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/provider/auth_provider.dart';
import 'package:news_app/screens/custom_search_delegate.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text('Are you sure you want to log out?'),
              title: const Text('Log out'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('NO')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      AuthProvider.logOut();
                    },
                    child: const Text('YES'))
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              child: const Icon(
                Icons.person_outline,
                size: 28,
                color: Colors.white,
              ),
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome Back!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(DateFormat.yMMMd().format(DateTime.now()))
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
