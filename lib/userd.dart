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




Widget loading(){
  return Scaffold(
    backgroundColor: Colors.white,
    body: Align(
      alignment: Alignment.center,
      child: Container(
        height: 75,
        width: 200,
        decoration: BoxDecoration(
        color: Colors.pink[400],
        borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Align(
          alignment:Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               CircularProgressIndicator(
                 strokeWidth: 0.7,
                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
               ) ,
               Text(
                 "    Loading..    ",
                 textScaleFactor: 1.4,
                 style: TextStyle(fontWeight: FontWeight.w200, fontFamily: "Roboto", color: Colors.white)
               ),
            ]
          ),
        )
      ),
    ),
  );
}
LocationData  locationData;
void  func() async{
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

  }
class Userd extends StatefulWidget {
  @override
  _UserdState createState() => _UserdState();
}

_Dataone maindata;
Image def = Image(
    image:AssetImage("assets/default.png"),
    height: 100,
    width: 100,
  );
bool found = false;
 class _Dataone {
  Future _doneFuture;
  String status;
  int userid; 
  String name;
  String mobile;
  String email;
  String password;
  LocationData loc ;
  _Dataone(){
    this.userid = null;
    this.status = null;
    this.name = null;
    this.mobile = null;
    this.email=  null;
    print("object");
    _doneFuture = getuserid();

  }
        
        Future<void> getuserid() async {
          var deviceId;
          print(deviceId);
          var url = "https://majormars.herokuapp.com/user_id";
          final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
          try {
            if (Platform.isAndroid) {
              var build = await deviceInfoPlugin.androidInfo;
              deviceId = build.androidId;  //UUID for Android
            } else if (Platform.isIOS) {
              var data = await deviceInfoPlugin.iosInfo;
              deviceId = data.identifierForVendor;  //UUID for iOS
            }
          } on PlatformException {
            print('Failed to get platform version');
          }
          
          print(deviceId);
          var response  = await http.post(url, 
          headers: {"Content-Type": "application/json"},
          body:jsonEncode({"device_id":deviceId})
          );
          var data = jsonDecode(response.body);
          this.userid =data["user_id"];
          this.status =  data["msg"];
          print(this.userid);
          print(this.status);
         // this.status = "NEW";
         // this.userid=  5584;
          print(userid);
          print(status);
          url = "https://majormars.herokuapp.com/user/"+this.userid.toString();
          response  = await http.get(url);
          try{
          data = jsonDecode(response.body);
          print(data);
          if(data.isEmpty){
            status = "NEW";
            return;
          }  
          this.name = data[0]["name"];
          this.email= data[0]["email"];
          this.mobile = data[0]["mobile"].toString();
          if(!(data[0]["dpimg"].isEmpty))
          {
            var imgurl = "https://majormars.herokuapp.com/";
            print("\n\n\nimahe\n\n\n");
            try{
              def = Image(
              fit: BoxFit.cover,
              image: NetworkImage(imgurl+data[0]["dpimg"][data[0]["dpimg"].length-1], scale: 0.5),  
              width: 110,
              height: 110,
              ); 
              found = true;
            }
            catch(e){
              def = Image(
                image:AssetImage("assets/default.png"),
                height: 100,
                width: 100,
              );
            }
          }
          }
          catch(e){
            print(e);
            this.status = "NEW";
          }
          print(status);
          return;
        }
        Future get initializationDone => _doneFuture;
}


class _UserdState extends State<Userd> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _Dataone _data1 = new _Dataone();
  


  Future<int> fun2() async {
    await _data1.initializationDone;
    return 1;
  }
  @override
  void initState() {
    super.initState(); 
    func();
    //fun2().((){print("Complete test");});
  }
  String _validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

    showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();
      Navigator.pushNamed(context, "/Homepage"); 
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.black,  
    title: Text("Welcome",style:TextStyle(color: Colors.white),textScaleFactor: 1.2),  
    content: Text("Thank you for Registration!", style:TextStyle(color: Colors.white),textScaleFactor: 1.2),  
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


Future<void> submit() async{
    _data1.loc = locationData;
    String url = "https://majormars.herokuapp.com/user";
    List<int> loc =[locationData.latitude.toInt(), locationData.longitude.toInt()];
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Name: ${_data1.name}');
      print('Mobile number: ${_data1.mobile}');
      print('Address: ${_data1.email}');
      print('Location: ${_data1.loc}');
      
      var response = await http.post(url, 
      headers: {"Content-Type": "application/json"},
      body:jsonEncode({
        "name":_data1.name,
        "user_id":_data1.userid.toString(),
        "mobile":_data1.mobile,
        "location":"["+loc[0].toString()+","+loc[1].toString()+"]",
        "email":_data1.email,
        "pass":"together"
      }));
      maindata = _data1; 
      print(response.body);
      _formKey.currentState.reset();

      showAlertDialog(context);

    }
}
  
  Color gradientStart = Colors.pink[400]; //Change start gradient color here
  Color gradientEnd = Colors.pink[900];
 @override 
 Widget build(BuildContext context){
   return FutureBuilder<int>(
     future: fun2(),
     builder: (BuildContext context, AsyncSnapshot<int> snapshot){
       if(snapshot.hasData){
             if(_data1.status=="NEW"){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(30,10),
              )),
              bottom: PreferredSize(
              preferredSize: Size.fromHeight(175),
              child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(alignment:Alignment.bottomLeft, child:Text(
                        'Create\nAccount !',
                        style: TextStyle(fontWeight: FontWeight.w400,fontFamily: "Roboto",color: Colors.grey, fontSize: 55),
                      )),
                    )
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
              ),

            body: Container(
                constraints: BoxConstraints.tightForFinite(),
                child:SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(75,30.0,75,0),
                                child: TextFormField(
                                  style: TextStyle(color:Colors.pink[400], fontSize: 25),
                                  cursorColor: Colors.pink[400],
                                  initialValue: _data1.name,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(color:Colors.pink,fontSize: 15),
                                    //contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                    labelText: 'Name',
                                  ),
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    this._data1.name = value;
                                  }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(75,10,75,0),
                                child: TextFormField(
                                  style: TextStyle(color:Colors.pink[400], fontSize: 25),
                                  cursorColor: Colors.pink[400],
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(color:Colors.pink, fontSize: 15),
                                    labelText: 'Mobile number',
                                  ),
                                  validator: _validateMobile,
                                  onSaved: (String value) {
                                    this._data1.mobile = value;
                                  }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(75,10,75,0),
                                child: TextFormField(
                                  style: TextStyle(color:Colors.pink[400], fontSize: 25),
                                  cursorColor: Colors.pink[400],
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(color:Colors.pink, fontSize: 15),
                                    labelText: 'Email address',
                                  ),
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Address is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    this._data1.email= value;
                                  }
                                ),
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0,50,50,0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8.0,50,0),
                                    child: ButtonTheme(
                                    minWidth: 70.0,
                                    height: 70.0,
                                    child: FlatButton(
                                      color: Colors.white,
                                      onPressed: this.submit,
                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(60.0)),
                                      child: Icon(
                                         Icons.arrow_forward,
                                         color: Colors.pink[400],             
                                         size:50,
                                      ), 
                                    ),
                                      ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  ],
              ),
                ),
            ),
          );}
        else{
          maindata = _data1;
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, "/Homepage");
            });
          });
          return Scaffold(
            backgroundColor: Colors.white,
        /*    appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(30,10),
              )),
              bottom: PreferredSize(
              preferredSize: Size.fromHeight(175),
              child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(alignment:Alignment.bottomLeft, child:Text(
                        'Welcome\nBack !',
                        style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Roboto",color: Colors.pink[400], fontSize: 50),
                      )),
                    )
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
              ),
*/
            body: Align(
              alignment: Alignment.center,
              child: Container(
                  child:SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 16.0),
                          Align(
                            child:Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                  "Welcome",
                                  style: TextStyle(fontWeight: FontWeight.w400,fontFamily: "Roboto",color: Colors.grey, fontSize: 45),
                                  ),
                                ),
                                Text(
                                _data1.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w300,fontFamily: "Roboto",color: Colors.pink[400], fontSize: 45),
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
        }
        else
            return loading();
        });
  }
            

}