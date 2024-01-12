import 'package:contacts/controller/addscreen_provider.dart';
import 'package:contacts/controller/internet_connectivity_provider.dart';
import 'package:contacts/view/home/screen_home.dart';
import 'package:contacts/view/update/screen_update.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AddContactProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => InternetConnectivityProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/update': (context) => const ScreenUpdate(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 100, 51, 185)),
        useMaterial3: true,
      ),
      home: const ScreenHome(),
    );
  }
}
