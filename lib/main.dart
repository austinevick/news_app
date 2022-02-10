import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/auth_state_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TesT(),
      ),
    );
  }
}

final categories = FutureProvider((ref) async {
  return ref.read(newsProvider).getNewsCategory();
});

class TesT extends ConsumerWidget {
  const TesT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(categories).when(
          data: (data) => ListView(
                children: data
                    // .where((element) => element.category == 'technology')
                    .map((e) => Text(
                          e.description!,
                          style: TextStyle(color: Colors.black),
                        ))
                    .toList(),
              ),
          error: (e, t) {},
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
