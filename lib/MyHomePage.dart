import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'main.dart';
import 'Homepage.dart';
import 'dart:async';
import 'userd.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  bool _flag = false; 
  final _textController = TextEditingController();
  ScrollController _scontroller = ScrollController();
  final titles = [];
  final abc = [];
  var intent = "no";
  var search;
  var url;
  var msg = '',reply='';


  void getData(String ss) async {
    print(intent);
    //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    String aa = "https://api.wit.ai/message?v=20200410&q=";
    http.Response res = await http.get(
      Uri.encodeFull(aa+ss),
      headers: {
        "Authorization":"Bearer SPIJO3NE4A5YQS3MHW4BI5EQHYAENQLJ"
      }
    );

    var d = jsonDecode(res.body);
    intent = d["entities"]["intent"][0]["value"] ;
    

    if(intent=="greeting"){
      
        reply = "Hello !";

    }
    
    else if(intent=="feeling"){
      reply = "I'm good. How are you ?";
      
    }
    else if(intent=="identity"){
      reply = "Hello, I'm MARS.Your personal companion.Hope you are doing good.";
      
    }

    else if(intent=="jokes"){
      var s = ["I ate a clock yesterday, it was very time-consuming.","What do you say to a kangaroo on its birthday? Hoppy Birthday !","Q. What do snowmen order at fast-food restaurants? A. An iceberg-er and fries!","Q: What has T in the beginning, T in the middle, and T at the end? A: A teapot","What do you call blueberries playing the guitar? A jam session.","A perfectionist walked into a bar...apparently, the bar wasn’t set high enough.","What's the difference between a good joke and a bad joke ...timing. ","I recently decided to sell my vacuum cleaner as all it was doing was gathering dust. ","Do I lose when the police officer says papers and I say scissors?"];
      var r = new Random();
      int intt = r.nextInt(8);
      reply = s[intt];
      
    }

    else if(intent=="recipe"){
      String a = "https://serpapi.com/search.json?q=";
      String b = "&hl=hi&gl=in&tbm=vid&google_domain=google.co.in&api_key=5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8";
      http.Response response = await http.get(
          
          Uri.encodeFull(a+ss+b),
          headers: {
            "Accept": "application/json",
            "key":"5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8"

      });
      var dataa = jsonDecode(response.body);
      url = dataa["video_results"][0]["link"];
      videoid = YoutubePlayer.convertUrlToId(url);

      reply = "Here is a video I found titled '"+dataa["video_results"][0]["title"]+"', click here to play it.";

    }
    
     else if(intent=="movement"){
       search = d["entities"]["search_query"][0]["value"] ;
      if(valueg == false){
        reply = "Error : Robot is not connected";

          
      }
      else{
        if(search=="left"){
          reply = "Robot moved left";
        
          Timer(Duration(seconds: 1), () {
            
          });
          http.get(link+"/left");
        }
        else if(search=="right"){
          reply = "Robot moved right";
          
          Timer(Duration(seconds: 1), () {
            
          });
          http.get(link+"/right");
        }
        else if(search=="forward"){
          reply = "Robot moved forward";
          
          Timer(Duration(seconds: 1), () {
            
          });
          http.get(link+"/aage");
        }
        else if((search=="backward")||(search=="back")){
          reply = "Robot moved back";

          Timer(Duration(seconds: 1), () {
            
          });
          http.get(link+"/peeche");
        }
      }
    }  
       
     else if(intent=="action"){

       search = d["entities"]["search_query"][0]["value"] ;

       if(valueg == false){
         reply = "Error : Robot is not connected";
          
      }

      else{
        url = link;

        if(search=="pic"){
          reply = "Picture is being displayed";


          Timer(Duration(seconds: 1), () {
            
          });

          if (await canLaunch(url)) { 
              await launch(url+"/imageclick");
          } else {
              throw 'Could not launch $url';
          }
        }

        else if(search=="live video feed"){
          reply = "Video is being displayed";


          Timer(Duration(seconds: 1), () {
            
          });
          
          if (await canLaunch(url)) { 
            await launch(url+"/video_feed");
          } else {
            throw 'Could not launch $url';
          }
        }
      }
    } 
    else if(intent=="news"){

      var r = new Random();
      int intt = r.nextInt(3);

      String a = "https://serpapi.com/search.json?q=";
      String b = "&hl=en&gl=us&google_domain=google.com&api_key=5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8";
      http.Response response = await http.get(
        
        Uri.encodeFull(a+ss+b),
        headers: {
          "Accept": "application/json",
          "key":"5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8"

        }
      );
      
      var dataa = jsonDecode(response.body);

      print(dataa["organic_results"][intt]["title"]);

      reply = "I found you the news. Tap here to read it."+dataa["organic_results"][intt]["title"];
      setState(() {

        url = dataa["organic_results"][intt]["link"];

        
      });        

    }

    else if(intent=="weather"){
      bool isloc = false;
      var loc;
      try{
        loc = d["entities"]["location"][0]["value"];
        isloc = true;
      }
      catch(e){
        isloc = false;
      }

      http.Response response;

      if(isloc){

        String a = "http://api.openweathermap.org/data/2.5/weather?q=";
        String b = "&appid=dc5ed26800222dc3b7a59ae6ef11f683&units=metric";

        response = await http.get(
          
          Uri.encodeFull(a+loc+b),
          headers: {
            "Accept": "application/json",
            "key":"dc5ed26800222dc3b7a59ae6ef11f683"

          }
        );
      }
      else{

        String a = "http://api.openweathermap.org/data/2.5/weather?lat="+locationData.latitude.toString()+"&lon="+locationData.longitude.toString();
        String b = "&appid=dc5ed26800222dc3b7a59ae6ef11f683&units=metric";

        response = await http.get(
          
          Uri.encodeFull(a+b),
          headers: {
            "Accept": "application/json",
            "key":"dc5ed26800222dc3b7a59ae6ef11f683"

          }
        );
      }
      
        var dataa = jsonDecode(response.body);
        reply = "Temperature : "+dataa["main"]["temp"].toString()+" degree celsius"+"\n"+"Min Temp : "+dataa["main"]["temp_min"].toString()+" degree celsius"+"\n"+"Max Temp : "+dataa["main"]["temp_max"].toString()+" degree celsius"+"\n"+"Condition : "+dataa["weather"][0]["main"];

  
    }


    else if(intent=="question"){
      String a = "https://serpapi.com/search.json?q=";
      String b = "&hl=en&gl=us&google_domain=google.com&api_key=5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8";
      http.Response response = await http.get(
        
        Uri.encodeFull(a+ss+b),
        headers: {
          "Accept": "application/json",
          "key":"5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8"

        }
      );
    
      var dataa = jsonDecode(response.body);
      reply = dataa["organic_results"][0]["snippet"];
      setState(() {
        
        url = dataa["organic_results"][0]["link"];
      });
    }


    else if(intent=="music"){
      print("hi");
      print(ss);
      String a = "https://serpapi.com/search.json?q=";
      String b = "&hl=hi&gl=in&tbm=vid&google_domain=google.co.in&api_key=5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8";
      http.Response response = await http.get(
          
          Uri.encodeFull(a+ss+b),
          headers: {
            "Accept": "application/json",
            "key":"5477edd0656af328405de67e5bfa788e55756353089300175663132d81aedbe8"

      });

      var dataa = jsonDecode(response.body);
      print(dataa);
      print(dataa["video_results"]);
      url = dataa["video_results"][0]["link"];
      if(url==Null){

      }
      videoid = YoutubePlayer.convertUrlToId(url);

      reply = "Here is a video I found titled '"+dataa["video_results"][0]["title"]+"', click here to play it.";

    }


    else if(intent=="no"){
      
      reply = "Sorry ! I couldn't get you. Ask me something in a different way";

    }


    setState(() {
    titles.add(reply);
    });

   var aaaa = {
     "chat":{
            "msg": msg,
            "reply":reply,
            "intent":intent 
            } 
          };
    var bbbb =  jsonEncode(aaaa);
    http.Response response = await  http.put(
      Uri.encodeFull("https://majormars.herokuapp.com/user/update/"+maindata.userid.toString()), 
      body:bbbb , 
      headers: { "Content-Type" : "application/json"}
    );

      print(response.body);

  }
  _launcher() async { 
    if (await canLaunch(url)) { 
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
        msg = string;

      titles.add(_textController.text);
      abc.add("You");
      getData(_textController.text);
      abc.add("Mars");
      _textController.clear();
      _flag=false;}
    });
        Timer(
    Duration(milliseconds: 1500),
    () => _scontroller
    .jumpTo(_scontroller.position.maxScrollExtent));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[400],
      appBar: AppBar(
        elevation: 0,
        title: Text('Chat'),
        backgroundColor: Colors.deepPurpleAccent[400],
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: 
                   BorderRadius.vertical(
                  top: Radius.elliptical(MediaQuery.of(context).size.width,50),
                ),
              ),
        child: Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              
              Expanded(
                  child:ListView.builder(
                    controller: _scontroller,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Card(                           
                        child: ListTile(
                          leading: Text(abc[index]), 
                          title: Text(titles[index]),
                          onTap: (){
                            if((intent=="question" && abc[index]=="Mars")||(intent=="news" && abc[index]=="Mars"))
                              _launcher();
                            if((intent=="recipe" && abc[index]=="Mars")||(intent=="music" && abc[index]=="Mars"))
                              Navigator.pushNamed(context, '/custom');
                          },
                        ),
                      );
                    },
                  ),
              ),
              
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    gapPadding: 1,
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
        ),
      ),
      
    );
  }
}