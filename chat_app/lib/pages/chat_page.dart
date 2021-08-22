import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [
    // ChatMessage(texto: 'Hola Mundo', uid: '123'),
    // ChatMessage(texto: 'Otro mensaje', uid: '51'),
    // ChatMessage(texto: 'Hola Mundo', uid: '123'),
    // ChatMessage(texto: 'Otro mensaje', uid: '51'),
    // ChatMessage(texto: 'Hola Mundo', uid: '123'),
    // ChatMessage(texto: 'Otro mensaje', uid: '123'),
    // ChatMessage(texto: 'Hola Mundo', uid: '123'),
    // ChatMessage(texto: 'Otro mensaje', uid: '51'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
       title: Column(
         
         children: [
           CircleAvatar(
             child: Text('Te', style: TextStyle(fontSize: 12)),
             backgroundColor: Colors.blue[100],
             maxRadius: 15,
           ),
           SizedBox(height: 3),
           Text('Melisa Flores', style: TextStyle(color: Colors.black87, fontSize: 12),)
         ],
       ),
       centerTitle: true,
       elevation: 1,
     ),
     body: Container(
       child: Column(
         children: [
           Flexible(
             child: ListView.builder(
               physics: BouncingScrollPhysics(),
               itemCount: _messages.length,
               itemBuilder: (_,i) => _messages[i],
               reverse: true,
            ),
          ),
          Divider(height: 1),
          //TODO: Caja de texto
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
         ],
       ),
     ),
   );
  }

  Widget _inputChat(){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handlSubmit,
                onChanged: (String texto){
                  setState(() {
                    if(texto.trim().length > 0){
                      _estaEscribiendo = true;
                    }
                    else{
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS 
              ? CupertinoButton(
                child: Text('Enviar'),
                onPressed: (){})
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send),
                    onPressed: _estaEscribiendo
                    ? () => _handlSubmit(_textController.text.trim())
                    : null
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handlSubmit(String texto){

    if(texto.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = new ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400)
      ));
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    //TODO off del socket
    for(ChatMessage chat in _messages){
      chat.animationController.dispose();
    }
    super.dispose();
  }
}