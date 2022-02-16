// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_ebook_app/views/auth/constants/constants.dart';
// import 'package:flutter_ebook_app/views/auth/login.dart';
// import 'package:flutter_ebook_app/views/auth/signup.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Login",
//       theme: ThemeData(primaryColor: Colors.orange[200]),
//       routes: <String, WidgetBuilder>{
//         SIGN_IN: (BuildContext context) => SignInPage(),
//         SIGN_UP: (BuildContext context) => SignUpScreen(),
//         HOMEPAGE: (BuildContext context) => SignUpScreen(),
//       },
//       initialRoute: SPLASH_SCREEN,
//     );
//   }
// }
