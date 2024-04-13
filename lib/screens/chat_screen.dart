import 'package:flutter/material.dart' ;
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:flutter/widgets.dart';


  final firestore = FirebaseFirestore.instance;
  late User user  ; 

class ChatScreen extends StatefulWidget {

static const String screenRoute ="chat_screen" ;

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextCrl = TextEditingController() ;
  final auth = FirebaseAuth.instance ;
  


  String? messageText ;

  @override
  void initState() {
    super.initState() ;
    getCurrentUser();    
  }
  void getCurrentUser()
  {
    if(auth.currentUser!=null)
    {
      user= auth.currentUser!;
      print(user.email) ;
    }
    
  }

  void messageStream() async
  {
     await for(var snapshot in firestore.collection('messages').snapshots())
     {
      for(var message in snapshot.docs)
      {
        print(message.data()) ;
      }
     }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Color.fromARGB(255, 18, 180, 180), title: Row(children: [
        Image.asset('images/chat2.png',height: 50,) ,
        SizedBox(width: 10,) ,
        Text('Message Me !')
      ],
      ),
      actions: [
        IconButton(onPressed: (){
          auth.signOut() ;
          Navigator.pop(context) ;
        },
         icon: Icon(Icons.close))
      ],
      ),

      body:  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextCrl,
                      onChanged: (value) {
                        messageText=value ;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      messageTextCrl.clear();
                      try {
                        await firestore.collection('messages').add({
                          'sender': user.email,
                          'text': messageText,
                          'time':FieldValue.serverTimestamp()
                        });
                      } catch (e) {
                        print('Error adding message to Firestore: $e');
                      }
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),



    ) ;
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('messages').orderBy('time').snapshots(),
              
              builder: (context , snapshot){
                List<MessageBadge> messageWidgets=[] ;

                  if(!snapshot.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    ) ;
                  }
                 final messages=snapshot.data!.docs ;
                 for(var message in messages)
                 { 
                  final messageText=message.get('text');
                  final messageSender= message.get('sender') ;
                  final currentUser = user.email ;


                  final messageWidget=MessageBadge(messageSender: messageSender,messageText: messageText,isMe:currentUser==messageSender) ;
                  messageWidgets.add(messageWidget) ;
                 }

                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    children: messageWidgets 
                  
                    
                  ),
                ) ;
              } ,
              
            );
  }
}

class MessageBadge extends StatelessWidget {
   MessageBadge({required this.messageSender, required this.isMe, required this.messageText}); 

  String messageText ; 
  String messageSender;
  bool isMe ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$messageSender',style: TextStyle(fontSize: 12 , color:Colors.black54),) ,
          Material(
            elevation: 5,
            borderRadius: isMe? BorderRadius.only(
              topLeft: Radius.circular(30) ,
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
            ) : BorderRadius.only(
              topRight: Radius.circular(30) ,
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
            ) ,
            color: isMe ? Colors.blue : Colors.white,
            
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
              child: Text('$messageText '  , style: TextStyle(fontSize: 15 , color: isMe? Colors.white :Colors.black ),),
            ),),
        ],
      ),
    );
  }
}