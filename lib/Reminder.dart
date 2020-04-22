import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Homepage.dart';
import 'userd.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Med {
  Med(this.title, [this.children = const []]);

  final String title;
  final List<String> children;
  void append(String s){
    children.add(s);
  }
}
var morn,aft,eve,medds;

Future<List> fun()async{
      http.Response response = await http.get(
          
          Uri.encodeFull("https://majormars.herokuapp.com/user/"+maindata.userid.toString()),
          headers: {
            "Accept": "application/json",

      });

      var dataa = jsonDecode(response.body);
      var da =  dataa[0]["routine"];
      print(da);
      print(da.length);
      if(da.length == 0){
        morn = Med('Morning',[]);
        aft =  Med('Afternoon',[]);
        eve = Med('Evening',[]);
      }
      else{
        List<String> morr=[],aftt=[],evee=[];
        for(var i in da){
        print(i);
        print(i["time"]);
          if(i["time"][0]==true){
            morr.add(i["med"]);
          }
          if(i["time"][1]==true){
            aftt.add(i["med"]);
          }
          if(i["time"][2]==true){
            evee.add(i["med"]);

          }
        }
        morn = Med('Morning',morr);
        aft =  Med('Afternoon',aftt);
        eve = Med('Evening',evee);
      }
        print(morn);
        print(aft);
        print(eve);

      medds = [morn, aft, eve];
      print(medds);
      print(medds.length);
      return medds;
}


void addmeds(var time, String med) async{

  var aaaa = {
     "routine":{
                "time": [
                    time[0],
                    time[1],
                    time[2]
                ],
                "med": med,
                "dose":1,
                "active": true
            },
          };
  var bbbb =  jsonEncode(aaaa);
    http.Response response = await  http.put(
      Uri.encodeFull("https://majormars.herokuapp.com/user/update/"+maindata.userid.toString()), 
      body:bbbb , 
      headers: { "Content-Type" : "application/json"}
    );

      print(response.body);

  if(time[0]==true){
    morn.append(med);
  }
  if(time[1]==true){
    aft.append(med);
  }
  if(time[2]==true){
    eve.append(med); 
  }

    

}

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override 
  void initState(){
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }
  @override
    Widget build(BuildContext context) {
    return FutureBuilder<List>(
     future: fun(),
     builder: (BuildContext context, AsyncSnapshot<List> snapshot){
       if(snapshot.hasData){
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent[400],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurpleAccent[400],
          title: const Text('Medicine List',style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white)),
          actions: <Widget>[
            FlatButton(
              onPressed: showNotification,
              onLongPress: delNotification, 
              child: Text(
                texts(),
                    style: TextStyle(color:Colors.white),
                  )
                ),        
              ],
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
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    EntryMeds(medds[index]),
                itemCount: medds.length,
              ),
            ),
          ),
        ),
      );
       }
       else{
         return loading();
       }
     }
    );
    }
      Future<void> delNotification() async {
        setState(() {
          notif = false;  
        });
        await flutterLocalNotificationsPlugin.cancelAll();
      }
      Future<void> showNotification() async {
        
        setState(() {
          notif = true;  
        });
        var time1 = Time(10,30,0);
        var time2 = Time(16,15,0);
        var time3 = Time(20, 15, 0);
        print("Done");
        var android = new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION');
        var iOS = new IOSNotificationDetails();
        var platform = new NotificationDetails(android, iOS);
        
        await flutterLocalNotificationsPlugin.showDailyAtTime(0,"Morning Medicine","Please take your Morning medicines",
          time1,platform);
        await flutterLocalNotificationsPlugin.showDailyAtTime(0,"Afternoon Medicine","Please take your Afternoon medicines",
          time2,platform);
        await flutterLocalNotificationsPlugin.showDailyAtTime(0,"Evening Medicine","Please take your Evening medicines",
          time3,platform);               
      }
                            
    String texts() {
      if(notif)
        return "Notification ON";
      else 
        return "Notification OFF";
    }
}

class EntryMeds extends StatefulWidget {
  const EntryMeds(this.entry);

  final Med entry;

  @override
  _EntryMedsState createState() => _EntryMedsState();
}

class _EntryMedsState extends State<EntryMeds> {
  Widget _buildTiles(Med root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Med>(root),
      title: Text(root.title),
      children: _listTiles(root,root.children),
    );
  }

  List<Widget> _listTiles(Med med, List<String> meds){
    final item = med; 
    List<Widget> test = meds.map((e){
      return ListTile(title: Text('$e'));
    }).toList();
    return test;
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.entry);
  }
}