import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

bool con_status = true;

void main(){ 
  
  runApp(       
     MaterialApp(
        theme: ThemeData(appBarTheme: AppBarTheme(elevation: 5.0, color:Colors.white)),
        title: 'Bot App',                      
        routes: <String, WidgetBuilder>{
          "/":(context)=>Homepage(),
          "/dashboard":(context)=>Dashboard()
        },
        onGenerateRoute: (RouteSettings settings){
          switch(settings.name){
            case '/': 
              return MaterialPageRoute(builder: (context)=>Homepage());
              break;
            case '/dashboard':
              return MaterialPageRoute(builder: (context)=>Dashboard());
            //case '/controller':
              //return MaterialPageRoute(builder: (context)=>Controller());
              break;
            default: return MaterialPageRoute(builder: (context)=>Homepage());
          }
        },
      )
  );
}

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
                        subtitle: Container(child: IconButton(iconSize: 16.0, icon: sub[index],)),
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

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _value=true;
  var _hint=" 192.168.0.1:500 ";
  TextEditingController _textFieldController = TextEditingController();
  _launcher() async {
  var url = link; 
  if (await canLaunch(url)) { 
    await launch(url+"/video_feed");
  } else {
    throw 'Could not launch $url';
  }
}
  void _onChanged(bool value){
    setState(() {
     _value=value;
     if(_value==true){
       link=" ";
     }
     if(_value==false){
     showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            "Enter the Mars IP for Offline use",
            textScaleFactor: 0.9,
            style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),
            ),
          content: Container(
            color: Colors.white,
            child: TextField(
                autofocus: true,
                onTap: (){_hint="";},
                controller: _textFieldController,
                decoration: InputDecoration(hintText: _hint),
                style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.black),
              ),
          ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                    _hint=" 192.168.0.1:500 ";
                    link=_textFieldController.text;
                    Navigator.of(context).pop();
                   }
                ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
              )
            ],
          backgroundColor: Colors.black,
          );
      }
     );} 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(            
                appBar:AppBar(
                  backgroundColor: Colors.black,
                  actions: <Widget>[
                    Switch(value:_value , onChanged: (bool value) {_onChanged(value);},)
                  ],
                  title: Text(
                  'Mars',
                  textDirection: TextDirection.ltr,
                  textScaleFactor: 1.0,
                  style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),
                        )
                      ),            
        backgroundColor: Colors.black,
        body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
             Row(  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_up), iconSize: 40, onPressed: () {http.get(link+"/up");},color: Colors.white,),],),
               Row(  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_down), iconSize: 40, onPressed: () {http.get(link+"/down");},color: Colors.white,),],),  
            ],),),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                  splashColor: Colors.red,  
                  color: Colors.black,
                  onPressed: ()async {
                       var url = link; 
                       if (await canLaunch(url)) { 
                              await launch(url+"/imageclick");
                          } else {
                              throw 'Could not launch $url';
                          }
                  },
                  child: Text(
                          "Take a pic",
                  style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                  ),
                  RaisedButton(
                    splashColor: Colors.red,
                    color: Colors.black,
                    onPressed: _launcher,
                    child: Text(
                      "Live Video Feed",
                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                    ),
                  RaisedButton(
                    splashColor: Colors.red,
                    color: Colors.black,
                     onPressed: (){Navigator.pushNamed(context, '/dashboard');},
                    child: Text(
                      "Chatbot",
                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                    ), 
                ],
              ),
            ),
            Row(  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_up), iconSize: 55, onPressed: () {http.get(link+"/aage");},color: Colors.white,),],),
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(icon: Icon(Icons.keyboard_arrow_left), iconSize: 55 , onPressed: () {http.get(link+"/left");},color: Colors.white,),
              IconButton(icon: Icon(Icons.keyboard_arrow_right),iconSize: 55 , onPressed: () {http.get(link+"/right");},color: Colors.white,)
            ],
            ),
            Row(  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_down), iconSize: 55, onPressed: () {http.get(link+"/peeche");},color: Colors.white,),],),
          ],
        ),
         /* add child content here */
      ),
      );
  }
}






