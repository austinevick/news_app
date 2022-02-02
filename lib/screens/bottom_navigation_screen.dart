import 'package:flutter/material.dart';
import 'package:news_app/screens/favourite_news_screen.dart';
import 'package:news_app/screens/home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final screens = [const HomeScreen(), const FavouriteNewsScreen()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 32,
          selectedItemColor: Colors.white,
          currentIndex: index,
          onTap: (value) => setState(() => index = value),
          items: [
            BottomNavigationBarItem(
                icon: AnimatedContainer(
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                        color: index == 0 ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(milliseconds: 800),
                    child: const Icon(Icons.home_filled)),
                label: ''),
            BottomNavigationBarItem(
                icon: AnimatedContainer(
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(
                        color: index == 1 ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(milliseconds: 800),
                    child: const Icon(Icons.favorite)),
                label: ''),
          ]),
    );
  }
}
