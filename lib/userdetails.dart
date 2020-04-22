import 'dart:ffi';

import 'Homepage.dart';
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:location/location.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'userd.dart';
import 'package:http_parser/http_parser.dart';

class UsedDetails extends StatefulWidget {
  @override
  _UsedDetailsState createState() => _UsedDetailsState();
}

class _UsedDetailsState extends State<UsedDetails> {
  Image def = Image(
    image:AssetImage("assets/default.png"),
    height: 200,
    width: 200,
  );
  File _img;
  Future<File> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _img = image;
      def = Image.file(
        _img,
        height: 200,
        width:200,
        );
        fun();
    });
    return image;
  }

  void fun() async {
           var url = "https://majormars.herokuapp.com/user/dpimg/"+maindata.userid.toString();
            var request =  http.MultipartRequest("PUT", Uri.parse(url));
            request.files.add( new http.MultipartFile.fromBytes( 'image', await _img.readAsBytes() , contentType: MediaType('image', 'jpeg/png'),));
            request.send().then((response) {
            print(maindata.userid.toString());
            print(Uri.parse(url));
            print("\n\n\n"+response.statusCode.toString()+"\n\n\n");
            }   
          );
        }
      
  Future<Image> imageSet() async {
    var url = "https://majormars.herokuapp.com/user/"+maindata.userid.toString();
    var imgurl = "https://majormars.herokuapp.com/";
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data);
    if(data[0]["dpimg"].length!=0){
      def = Image(
        image: NetworkImage(imgurl+data[0]["dpimg"][data[0]["dpimg"].length-1], scale: 0.5),  
        width: 200,
        height: 200,
      );
    }
    print(def);
    return def;
  }

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
      future: imageSet(),
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot){
        if(snapshot.hasData){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Align(
              alignment: Alignment.center,
              child: Container(
                  child:SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipOval(child: def)),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                      "USER ID",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontFamily: "Monospace",color: Colors.pink[400], fontSize: 25),
                                      ),
                                      Text(
                                      maindata.userid.toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Roboto",color: Colors.pink[400], fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),     
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                      "NAME",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontFamily: "Monospace",color: Colors.pink[400], fontSize: 25),
                                      ),
                                      Text(
                                      maindata.name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Roboto",color: Colors.pink[400], fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                      "MOBILE NUMBER",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontFamily: "Monospace",color: Colors.pink[400], fontSize: 25),
                                      ),
                                      Text(
                                      maindata.mobile,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Roboto",color: Colors.pink[400], fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                      "EMAIL",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontFamily: "Monospace",color: Colors.pink[400], fontSize: 25),
                                      ),
                                      Text(
                                      maindata.email,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Roboto",color: Colors.pink[400], fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),                           
                              ]
                            )
                          ),
                        ],
                      ),
                    ),  
                ),
               ),
            );
        }
        else{
          return loading();
        }
      });
     }
}