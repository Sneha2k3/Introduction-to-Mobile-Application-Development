import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shadowpass/screens/addpassword.dart';
import 'package:shadowpass/screens/forgotpass.dart';
import 'package:shadowpass/screens/home.dart';
import 'package:shadowpass/screens/login.dart';
import 'package:shadowpass/screens/profilePage.dart';
import 'package:shadowpass/screens/register.dart';
import 'package:shadowpass/viewmodel/passwordviewmodel.dart';
import 'package:firebase/firebase.dart' as fb;


import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   //Add providers here
    //   providers: [
    //     ChangeNotifierProvider(create: (_)=>PasswordViewModel()),
    //   ],
      return MaterialApp(
        title: 'shadowpass',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF262625), // Set dark mode background color
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: "/login",
        routes: {
          "/home":(context)=> HomeScreen(),
          "/login":(context)=> LoginPage(),
          "/register":(context)=> RegisterPage(),
          "/forgot_password":(context)=>ForgotPasswordPage(),
          "/addpassword":(context)=>AddPasswordPage(),
          "/profile":(context)=>ProfilePage(),
        },
      );
  }
}