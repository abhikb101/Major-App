import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Reminder.dart';
import 'hrate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import 'tempr.dart';
import 'userd.dart';
import 'medhpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';





//bool sos = false;
bool notif = false;
/* LocationData  locationData; */
bool valueg=false;
final titless = [
  
];
var link="https://previews.123rf.com/images/releon003/releon0031702/releon003170200113/72386812-abstract-robot-eye-background.jpg";

int btindex=1;

class Homepage extends StatefulWidget {

  
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  ProgressDialog pr;
  var _hint=" 192.168.0.1:500 ";
  TextEditingController _textFieldController = TextEditingController();

// Medhpage med = new Medhpage();


Widget card(){
  try{ 
    return GestureDetector(
      onDoubleTap: (){        
          if(valueg == false){
                    alert(context);
                    return ;
                }
          http.get(link+"/detect?uid="+maindata.userid.toString());
      },
      onTap: (){
        Navigator.of(context).pushNamed("/userd");
      },
      child: Padding(
        padding: const EdgeInsets.only(top:30.0),
        child: SizedBox(
        height: 300,
        width: 300,
        child:Column(children: <Widget>[
          ClipOval(
            child: def),
          Padding(
            padding: const EdgeInsets.only(top:15),
            child: Align(
                child: Text(
                maindata.name,
                style:TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.white,
                        fontFamily: 'Monospace',
                        fontSize: 30,
                      ),
              ),
            ),
          ),
        ],)
    ),
      ),
  );
  }
  catch(e){
        return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed("/userd");
      },
      child: SizedBox(
      height: 300,
      width: 300,
      child:Column(children: <Widget>[
        Image(
                image:AssetImage("assets/default.png"),
                height: 100,
                width: 100,
              ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Align(
            alignment: Alignment.center,
              child: Text(
              maindata.name,
              style:TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontFamily: 'Monospace',
                      fontSize: 25,
                    ),
            ),
          ),
        ),
      ],)
    ),
  );
  }
}
/* void  func() async{
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();

  } */

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

  /* _medalert(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Add Medicine to Reminder Lists"),
        content: Container(
//          constraints: BoxConstraints.tight(Size.square(100)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                Text("Select Time: "),
                              DropdownButton<String>(
                value: _time,
                items: <String>['Morning', 'Afternoon', 'Evening']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value),
                    );
                  })
                  .toList(),
               onChanged: (String newValue) {
                    setState(() {
                     _time=newValue;
                     Navigator.pop(context);
                     _medalert(context);
                  });
              },),
              ],),
              TextField(
                  autofocus: true,
                  onTap: (){_hintm="";},
                  controller: _mtextFieldController,
                  decoration: InputDecoration(hintText: _hintm),
                  style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.black),
                ),
            ],),
        ),
          actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                    _hintm=" Medicine Name ";
                    if(_mtextFieldController.text!="")
                      addmeds(_time, _mtextFieldController.text);
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
      );
    });
} */
  _launcher() async {
    var url = link; 
    if (await canLaunch(url)) { 
      await launch(url+"/video_feed");
    } else {
      throw 'Could not launch $url';
    }
  }

showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("SOS Alert"),  
    content: Text("The message has been sent to the registered contact(s) !"),  
    actions: [  
      okButton,  
    ],  
  );
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },   
  );

}
showAlertDialog1(BuildContext context) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Message"),  
    content: Text("You have not filled the SOS registeration form. Kindly fill the form first !"),  
    actions: [  
      okButton,  
    ],  
  );


  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );

}

showAlertDialog3(BuildContext context,int value) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Temperature"),  
    content: Text("The temperature reading is "+value.toString()+" F"),  
    actions: [  
      okButton,  
    ],  
  );
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );

}

showAlertDialog4(BuildContext context,int value) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Heart Rate"),  
    content: Text("The Heart rate reading is "+value.toString()+" bpm"),  
    actions: [  
      okButton,  
    ],  
  );
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );

}


/* void _medfunc(){
  _medalert(context);
} */
void _sosfunc() async{

  http.Response response = await http.get(
          
          Uri.encodeFull("https://majormars.herokuapp.com/user/"+maindata.userid.toString()),
          headers: {
            "Accept": "application/json",

      });
var dataa = jsonDecode(response.body);
var da =  dataa[0]["sos"];
print(da.length);
  if(da.length!=0){
      http.get("https://majormars.herokuapp.com/sos/2/"+maindata.userid.toString());
     showAlertDialog(context);
  }
  else{

    showAlertDialog1(context);
  }

}

  void _onChanged(bool value){
    setState(() {
     valueg=value;
     if(valueg==true){
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
  void initState() {
    func();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
          message: '  Loading..',
          borderRadius: 40.0,
          backgroundColor: Colors.pink[400],
          progressWidget: CircularProgressIndicator(
            strokeWidth: 0.7,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
            color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w200),
          messageTextStyle: TextStyle(
            color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w200),
            textAlign: TextAlign.justify,
            progressWidgetAlignment: Alignment.centerRight
        );

    return Scaffold( 
         
      drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                    'Mars.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.0,
                      color: Colors.white,
                      fontFamily: 'Monospace',
                      fontSize: 50,
                      ),
                    ),
                ),

                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent[400],
                ),
              ),
              ListTile(
                title: Text('HomePage'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('User details'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/userd');
                },
              ),
              ListTile(
                title: Text('SOS Form'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/SosForm');
                  
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Medicine Reminder'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/Medicine_Reminder');
                },
              ),
              ListTile(
                title: Text('Temperature Logs'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/tempp');
                },
              ),
              ListTile(
                title: Text('Heart rate Logs'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/hrate');
                },
              ),
            ],
          ),// Populate the Drawer in the next step.
      ),         
      resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: CustomScrollView(
        
//          shrinkWrap: true,
          slivers:<Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(MediaQuery.of(context).size.width,50),
                ),
              ),
              
              backgroundColor: Colors.deepPurpleAccent[400],
              expandedHeight: 300,
              floating: false,
              pinned: true,
              title: Text(
                "Mars",
                  textDirection: TextDirection.ltr,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontFamily: 'Monospace',
                    fontSize: 20,
                    ),
                ),
                flexibleSpace: Padding(
                  padding: const EdgeInsets.fromLTRB(0,100,0,0),
                  child: card(),
                ),
              actions: <Widget>[
                Medhpage(),
                    IconButton(icon: Icon(Icons.all_inclusive), iconSize: 30, onPressed: () {_sosfunc();}),
                    Switch(value:valueg , onChanged: (bool value) {_onChanged(value);},)
              ],
            ),
            SliverFillRemaining(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Row(  mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_up), iconSize: 40, onPressed: () {
                                if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                                http.get(link+"/up");},color: Colors.black),],),
                              Row(  mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_down), iconSize: 40, onPressed: () {
                                if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                                http.get(link+"/down");},color: Colors.black,),],),  
                            ],),),
                            Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                  splashColor: Colors.red,  
                                  color: Colors.white,
                                  onPressed: ()async {
                                      var url = link; 
                                      if(valueg == false){
                                          alert(context);
                                          return ;
                                      }

                                      if (await canLaunch(url)) { 
                                              await launch(url+"/imageclick");
                                          } else {
                                              throw 'Could not launch $url';
                                          }
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Image( image: AssetImage("assets/Camera.png" ,),height:30,width:30),
                                      Text("Take a pic")
                                    ],
                                  ),
                                  ),
                                  FlatButton(
                                    splashColor: Colors.red,
                                    color: Colors.white,
                                    onPressed:(){ 
                                      if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                                      _launcher();},
                                    child: Column(
                                      children: <Widget>[
                                        Image( image: AssetImage("assets/Video.png" ,),height:30,width:30),
                                        Text("Live Video Feed",),
                                      ],
                                    ),
                                    ),
                                  /* RaisedButton(
                                    splashColor: Colors.red,
                                    color: Colors.black,
                                    onPressed: (){Navigator.pushNamed(context, '/dashboard');},
                                    child: Text(
                                      "Chatbot",
                                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                                    ),  */
                      
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: FlatButton(
                                      splashColor: Colors.red,
                                      color: Colors.white,
                                      onPressed: (){Navigator.pushNamed(context, '/MyHomePage');},
                                      child: Column(
                                        children: <Widget>[
                                           Image( image: AssetImage("assets/chat.png" ,),height:30,width:30),
                                          Text(
                                            "Chatbot",),
                                        ],
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35.0,35.0,35.0,70.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                  splashColor: Colors.red,  
                                  color: Colors.white,
                                  onPressed: ()async {
                                      
                                      if(valueg == false){
                                          alert(context);
                                          return ;
                                      }

                                      pr.show();

                                    var e;
                                      String aa = link+"/tempr";
                                      try{
                                      http.Response res = await http.get(
                                        Uri.encodeFull(aa),
                                        
                                      );


                                      var d = jsonDecode(res.body);
                                      print(d);
                                      e = d["temp"];
                                      }
                                      catch(Exception) {
                                          //Handle Exception
                                      } finally {
                                        pr.hide();
                                      }    

                                      print(DateTime.now());

                                    showAlertDialog3(context,e);

                                    var abc = DateTime.now();

                                    var aaaa =  {"body_temp":e.toString()+","+abc.toString()};
                                    var bbbb = jsonEncode(aaaa);
                                    http.Response response = await  http.put(
                                      Uri.encodeFull("https://majormars.herokuapp.com/user/update/"+maindata.userid.toString()), 
                                      body:bbbb ,  
                                      headers: {"Content-Type": "application/json"}

                                    );
                                      
                                      print(response.body);
                                    

                                  },
                                  child: Column(
                                    children: <Widget>[
                                       Image( image: AssetImage("assets/temp.png" ,),height:30,width:30),
                                      Text("Temperature Sensor",),
                                    ],
                                  ),
                                  ),
                                  FlatButton(
                                    splashColor: Colors.red,
                                    color: Colors.white,
                                    onPressed:() async{ 
                                      if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                                      pr.show();

                                      var e;
                                      String aa = link+"/heart";
                                      print(aa);
                                      try{
                                      http.Response res = await http.get(
                                        Uri.encodeFull(aa),
                                        
                                      );

                                      var d = jsonDecode(res.body);
                                      e = d["heart"];
                                      print(e);
                                      }
                                      catch(Exc) {
                                          print("\n\n\n"+Exc+"\n\n\n\n");
                                      } finally {
                                        pr.hide();
                                      }
                                      showAlertDialog4(context,e);

                                      var abc = DateTime.now();

                                    var aaaa =  {"heart_rate":e.toString()+","+abc.toString()};
                                    var bbbb = jsonEncode(aaaa);
                                    http.Response response = await  http.put(
                                      Uri.encodeFull("https://majormars.herokuapp.com/user/update/"+maindata.userid.toString()), 
                                      body:bbbb ,  
                                      headers: {"Content-Type": "application/json"}

                                    );
                                    print(response.body);

                                    
                                      },
                                    child: Column(
                                      children: <Widget>[
                                         Image( image: AssetImage("assets/h.png" ,),height:30,width:30),
                                        Text("Heart rate Sensor",),
                                      ],
                                    ),
                                    ),
                                  /* RaisedButton(
                                    splashColor: Colors.red,
                                    color: Colors.black,
                                    onPressed: (){Navigator.pushNamed(context, '/dashboard');},
                                    child: Text(
                                      "Chatbot",
                                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
                                    ),  */ 
                                ],
                              ),
                            ),
                            Row(  mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_up), iconSize: 55, onPressed: () {
                                if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                                http.get(link+"/aage");},color: Colors.black,),],),
                            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.keyboard_arrow_left), iconSize: 55 , onPressed: () {
                                if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                                http.get(link+"/left");},color: Colors.black,),
                              IconButton(icon: Icon(Icons.keyboard_arrow_right),iconSize: 55 , onPressed: () {
                                if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                                http.get(link+"/right");},color: Colors.black,)
                            ],
                            ),
                            Row(  mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[IconButton(icon: Icon(Icons.keyboard_arrow_down), iconSize: 55, onPressed: () {
                              if(valueg == false){
                                          alert(context);
                                          return ;
                                      }
                              http.get(link+"/peeche");},color: Colors.black,),],),
                          ],
                        ),
                  ),
          ),]
        ),
    );
  }
}