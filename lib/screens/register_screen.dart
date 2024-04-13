import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/welcome_page.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:flutter/material.dart' ;
import 'package:firebase_auth/firebase_auth.dart' ;   
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart' ;

class RegisterScreen extends StatefulWidget {

  static const String screenRoute ="register_screen" ;

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final auth = FirebaseAuth.instance ; 

   late String email ; 
   late String password ;

    bool spinner=false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      body:ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
            Container( 
              height: 180 ,
              child: Image.asset('images/chat2.png'),
              
            ) ,
            SizedBox(height: 50,),
            TextField(
              
              textAlign: TextAlign.center,
            onChanged: (value){
              email=value ;
            },
            decoration: InputDecoration(
              hintText: 'Enter your Email' ,
              contentPadding: EdgeInsets.symmetric(vertical: 10  , horizontal: 20) ,
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))) ,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue , width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))) ,
        
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: const Color.fromARGB(255, 143, 131, 20) , width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))) 
            )
            
            
            ,) ,
            SizedBox(height: 8.0) ,
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
            onChanged: (value){
              password=value ;  
            },
            decoration: InputDecoration(
              hintText: 'Enter your Password' ,
              contentPadding: EdgeInsets.symmetric(vertical: 10  , horizontal: 20) ,
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))) ,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue , width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))) ,
        
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: const Color.fromARGB(255, 143, 131, 20) , width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))) 
            )
            
            
            ,) ,
            SizedBox(height: 10,) ,
            MyButton(color: Colors.blue, title: "Register", onPressed: () async {

              setState(() {
                spinner=true ;
              });

              try {
               final userAuth = await  auth.createUserWithEmailAndPassword(email: email, password: password);
               Navigator.pushNamed(context, ChatScreen.screenRoute) ;

               setState(() {
                 spinner=false;
               });
              }
              catch(e)
              {
                print(e) ;
              }
              
        
            })
          ],),
        ),
      )
    
    
    
    );
  }
}