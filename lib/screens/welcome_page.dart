import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {

  static const String screenRoute ="welcome_screen" ;
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        
           Column(
            
        
        
            
           
        
        
        
            children: [
            Container(
              child: Image.asset("images/chat2.png"),
              height: 180.0,
            ) ,
            Text("Message ME !" , style :TextStyle(fontSize: 40 , fontWeight: FontWeight.bold , color: Colors.black))
          ],
          ) , 
          SizedBox(height: 30,) , 
          MyButton(color: const Color.fromARGB(255, 88, 175, 247),
           title:"Sign in " ,
            onPressed: ()
            {
              Navigator.pushNamed(context, SigninScreen.screenRoute) ;
            },
            ),
          MyButton(color: const Color.fromARGB(255, 11, 70, 117),
           title:"Register " ,
            onPressed: (){
              Navigator.pushNamed(context, RegisterScreen.screenRoute) ;
            },)
          ],
          
          
        
         
        ),
      )
    ) ;
  }
}

