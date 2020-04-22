import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'userd.dart';

var link="https://previews.123rf.com/images/releon003/releon0031702/releon003170200113/72386812-abstract-robot-eye-background.jpg";


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
   bool _flag = false; 

  final _textController = TextEditingController();

  List message = [];
  List name = [];
  List sub=[];
  var _hint="Enter text to send";
  Future _getData (String chat) async {
    
    http.Response respose = await http.get(link+"/chat?msg="+chat);
    Map data = json.decode(respose.body);
    debugPrint(data['reply']);
    setState((){
    message.add(data['reply']);
    sub.add(Icon(Icons.check_box));
    });
  }
  _onSubmit(){
    setState(() {
       _hint="Enter text to send";
      int range=_textController.text.length;
      var string=_textController.text;
      for(int i=0; i<range;i++)
      {
        if(string[i] != " ")
          _flag=true;
      }
      if(_textController.text!="" && _flag){
        _getData(_textController.text);
      message.add(_textController.text);
      name.add("You");
      sub.add(Icon(Icons.check_box_outline_blank));
      name.add("Mars");
      _textController.clear();
      _flag=false;}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Chat', style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
      ),
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/home.jpg"),
              fit: BoxFit.cover,
              ),
            ),
        //color: Colors.black,
        child: Column(
          children: <Widget>[
           // SizedBox(height: 20.0),
            Expanded(
                child:ListView.builder(
                  itemCount: message.length,
                  itemBuilder: (context, index) {
                    return Card(                           
                      child: ListTile(

                        leading: Text(name[index]), 
                        title: Text(message[index]),
                        subtitle: Container(child: sub[index]),
                      ),
                    );
                  },
                ),
            ),
            
            Container(
              color: Colors.white,
              child: TextField(
                autofocus: true,
                onTap: (){_hint="";},
                controller: _textController,
                decoration: InputDecoration(hintText: _hint, suffix:IconButton( icon: Icon((Icons.send)),onPressed: _onSubmit, )),
                style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}