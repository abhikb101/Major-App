import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';




alert(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Enter the Robot Access URL"),
        content: Text("Enable the toggle and Enter the URL"),
        actions: [FlatButton(
          onPressed:(){ Navigator.of(context).pop();}, child: Text("ok!"))],
      );
    });
}
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _value=false;
  var link="https://previews.123rf.com/images/releon003/releon0031702/releon003170200113/72386812-abstract-robot-eye-background.jpg";
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
                    if(_textFieldController.text!="")
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
              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_up), iconSize: 40, onPressed: () {
                if(_value == false){
                          alert(context);
                          return ;
                       }
                http.get(link+"/up");},color: Colors.white,),],),
               Row(  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_down), iconSize: 40, onPressed: () {
                if(_value == false){
                          alert(context);
                          return ;
                       }
                http.get(link+"/down");},color: Colors.white,),],),  
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
                       if(_value == false){
                          alert(context);
                          return ;
                       }
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
                    onPressed:(){ 
                      if(_value == false){
                          alert(context);
                          return ;
                       }
                      _launcher();},
                    child: Text(
                      "Live Video Feed",
                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                    ),
                   /* RaisedButton(
                    splashColor: Colors.red,
                    color: Colors.black,
                     onPressed: (){Navigator.pushNamed(context, '/dashboard');},
                    child: Text(
                      "Chatbot",
                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                    ),  */
                  RaisedButton(
                    splashColor: Colors.red,
                    color: Colors.black,
                     onPressed: (){Navigator.pushNamed(context, '/MyHomePage');},
                    child: Text(
                      "Chatbot2",
                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                    ),  
                ],
              ),
            ),
            Row(  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_up), iconSize: 55, onPressed: () {
                if(_value == false){
                          alert(context);
                          return ;
                       }
                http.get(link+"/aage");},color: Colors.white,),],),
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(icon: Icon(Icons.keyboard_arrow_left), iconSize: 55 , onPressed: () {
                if(_value == false){
                          alert(context);
                          return ;
                       }
                http.get(link+"/left");},color: Colors.white,),
              IconButton(icon: Icon(Icons.keyboard_arrow_right),iconSize: 55 , onPressed: () {
                if(_value == false){
                          alert(context);
                          return ;
                       }
                http.get(link+"/right");},color: Colors.white,)
            ],
            ),
            Row(  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_down), iconSize: 55, onPressed: () {
              if(_value == false){
                          alert(context);
                          return ;
                       }
              http.get(link+"/peeche");},color: Colors.white,),],),
          ],
        ),
         /* add child content here */
      ),
      );
  }
}