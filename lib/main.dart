import 'package:flutter/material.dart';
import 'package:platform_converter/provider/contect_provider.dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:platform_converter/veiw/screens/add_contact_page.dart';
import 'package:platform_converter/veiw/screens/detail_page.dart';
import 'package:platform_converter/veiw/screens/home_page.dart';
import 'package:platform_converter/veiw/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'HomeScreen': (context) =>  HomeScreen(),
          'AddContact': (context) => AddContact(),
          'DetailScreen': (context) => DetailScreen(),
        },
      ),
    ),
  );
}
