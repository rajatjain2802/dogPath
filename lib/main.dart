import 'package:dog_path_app/model/view/HomeViewModel.dart';
import 'package:dog_path_app/ui/HomeScreen.dart';
import 'package:dog_path_app/ui/LoginScreen.dart';
import 'package:dog_path_app/ui/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/network/api/BaseApi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    BaseApis.setEnvironment(Environment.STAGING);
  } else {
    BaseApis.setEnvironment(Environment.PROD);
  }
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen()
      },
    );
  }
}
