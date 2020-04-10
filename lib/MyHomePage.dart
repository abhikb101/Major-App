import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  bool _flag = false; 
  final _textController = TextEditingController();

  final titles = [];
  final abc = [];


  void getData(String ss) async {

    String aa = "https://api.wit.ai/message?v=20200410&q=";
    http.Response res = await http.get(
      Uri.encodeFull(aa+ss),
      headers: {
        "Authorization":"Bearer SPIJO3NE4A5YQS3MHW4BI5EQHYAENQLJ"
      }
    );

    var d = jsonDecode(res.body);
    var intent = d["entities"]["intent"][0]["value"] ;

    if(intent=="greeting"){
      setState(() {
        titles.add("Hello !");
      });
    }
    else if(intent=="identity"){
      titles.add("Hello, I'm MARS.Your personal companion.Hope you are doing good.");
    }
    else if(intent=="jokes"){
      titles.add("");
    }
    else if(intent=="Recipe"){

    }
    else if(intent=="news"){
      

    }
    else if(intent=="weather"){

    }
    else if(intent=="question"){

    }
    else if(intent=="music"){
      String a = "https://serpapi.com/search.json?q=";
      String b = "&hl=hi&gl=in&google_domain=google.co.in&api_key=5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8";
      http.Response response = await http.get(
        
        Uri.encodeFull(a+ss+b),
        headers: {
          "Accept": "application/json",
          "key":"5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8"

        }
      );
    

      var dataa = jsonDecode(response.body);
      setState(() {
        titles.add(dataa["inline_videos"][0]["link"]);
      });
    }
    else{
      String a = "https://serpapi.com/search.json?q=";
      String b = "&hl=hi&gl=in&google_domain=google.co.in&api_key=5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8";
      http.Response response = await http.get(
        
        Uri.encodeFull(a+ss+b),
        headers: {
          "Accept": "application/json",
          "key":"5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8"

        }
      );
    

      var dataa = jsonDecode(response.body);
      setState(() {
        titles.add(dataa["organic_results"][0]["title"]);
      });
    }
    
    

  }

  _onSubmit(){
    setState(() {
      int range=_textController.text.length;
      var string=_textController.text;

      

      for(int i=0; i<range;i++)
      {
        if(string[i] != " ")
          _flag=true;
      }
      if(_textController.text!="" && _flag){
      titles.add(_textController.text);
      abc.add("You");
      getData(_textController.text);
      abc.add("Mars");
      _textController.clear();
      _flag=false;}
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        
      ),
      
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          
          Expanded(
              child:ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Card(                           
                    child: ListTile(
                      leading: Text(abc[index]), 
                      title: Text(titles[index]),
                    ),
                  );
                },
              ),
          ),
          
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              suffix: IconButton( 
                icon: Icon((Icons.send)),
                onPressed: _onSubmit,
              ),
              hintText: ' Enter text to send',
            ),
          ),
        ],
      ),
    );
  }
}