import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:svrkxmdvm/firebase_options.dart';
import 'package:svrkxmdvm/pages/Home.dart';
import 'package:svrkxmdvm/pages/Login.dart';
import 'package:svrkxmdvm/providers/PlaylistProvider.dart';
import 'package:provider/provider.dart';
import 'package:svrkxmdvm/themes/theme_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers:[
    ChangeNotifierProvider(create: (_)=>ThemeProvider()) ,
    ChangeNotifierProvider(create: (_)=>PlayListProvider()) ,
  ],child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:Provider.of<ThemeProvider>(context).themeData,
      home:Home(),
    );
  }
}

