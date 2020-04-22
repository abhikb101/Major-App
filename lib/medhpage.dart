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
import 'Homepage.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class Box extends StatefulWidget{
  @override
  _BoxState createState() => _BoxState();
}

  bool morning = false;
  bool afternoon = false; 
  bool evening = false;

class _BoxState extends State<Box> {
  bool _morning = false;
  bool _afternoon = false; 
  bool _evening = false;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Morning"),
                Checkbox(
                  value: _morning,
                  onChanged: (bool value) {
                    setState(() {
                      morning = value;
                      _morning = value;
                    });
                  },
                ),
              ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Afternoon"),
                Checkbox(
                  value: _afternoon,
                  onChanged: (bool value) {
                    setState(() {
                      afternoon = value;
                      _afternoon = value;
                    });
                  },
                ),
              ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Evening"),
                Checkbox(
                  value: _evening,
                  onChanged: (bool value) {
                    setState(() {
                      evening = value;
                      _evening = value;
                    });
                  },
                ),
              ],
          ),
        ],
      );
  }
}
class Medhpage extends StatefulWidget {

  
  @override
  _Medhpage createState() => _Medhpage();
}

class _Medhpage extends State<Medhpage> {
 var _hintm=" Medicine Name ";
 var _time;
 TextEditingController _mtextFieldController = TextEditingController();
_medalert(BuildContext context){
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
                Box(),
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
                    if(_mtextFieldController.text!=""){
                      _time = [morning,afternoon,evening];
                      print(_time);
                      addmeds(_time, _mtextFieldController.text);
                    }
                    morning = false;
                    afternoon = false;
                    evening= false;
                     _mtextFieldController.clear();
                    Navigator.of(context).pop();
                   }
                ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  _mtextFieldController.clear();
                  Navigator.of(context).pop();
                }, 
              )
            ],
      );
    });
}


void _medfunc(){
  _medalert(context);
}

 @override
  Widget build(BuildContext context) {
                    return FlatButton(child:Text(
                      "Add Meds",
                      style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white)
                      ) ,onPressed:(){
                      _medfunc();
                    });
  }

}