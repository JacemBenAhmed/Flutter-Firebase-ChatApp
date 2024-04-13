import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:firebase_auth/firebase_auth.dart' ;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp() ;
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final auth = FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CHAT APP ",
      //home:ChatScreen() ,
      initialRoute: auth.currentUser==null ? WelcomePage.screenRoute : ChatScreen.screenRoute ,
      routes: {
        WelcomePage.screenRoute : (context)=>WelcomePage() ,
        SigninScreen.screenRoute : (context)=>SigninScreen() ,
        RegisterScreen.screenRoute : (context)=>RegisterScreen() ,
        ChatScreen.screenRoute : (context)=>ChatScreen() ,
      },

    ) ;
  }
}