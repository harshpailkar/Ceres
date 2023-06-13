import 'package:epic_project/screens/authentication/SignInPage.dart';
import 'package:epic_project/screens/authentication/SignUpForm.dart';
import 'package:epic_project/screens/authentication/SignUpPage.dart';
import 'package:epic_project/screens/firstpage.dart';
import 'package:epic_project/screens/navSetup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter',
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade200),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xff00C880),
        cardColor: Colors.grey.shade200,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.transparent,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter',
        drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xff00C880),
        cardColor: Colors.grey.shade800,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Ceres',
      home: StreamBuilder<User?>(stream:FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasData){
          return  navSetup() ;
        }
        else{
          return  SignUpPage();
        }
      }),
    );
  }
}
