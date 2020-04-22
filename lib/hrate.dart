import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'userd.dart';
import 'dart:convert';


class Hrate extends StatefulWidget {


  @override
  _HrateState createState() => _HrateState();
}


class _HrateState extends State<Hrate> {



  final List<Map<String,String>> titless = [];
 var da,dataa;

Future<List<Map<String,String>>> func() async{
http.Response response = await http.get(
          
          Uri.encodeFull("https://majormars.herokuapp.com/user/"+maindata.userid.toString()),
          headers: {
            "Accept": "application/json",

      });
dataa = jsonDecode(response.body);
da =  dataa[0]["heart_rate"];
print(da);
 for(var cc in da){
  print(cc);
  var  b = cc.toString().split(",");
  print(b[0]);
  var c = b[1].toString().split(" ");
  print(c[0]);
  print(c[1]);
  titless.add(
    {
      "heartrate":b[0].toString(),
      "date":c[0].toString(),
      "time":c[1].toString()
    });
}

return titless;

}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String,String>>>(
     future: func(),
     builder: (BuildContext context, AsyncSnapshot<List<Map<String,String>>> snapshot){
       if(snapshot.hasData){
          return Scaffold(
            backgroundColor: Colors.deepPurpleAccent[400],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.deepPurpleAccent[400],
              title: Text('Heart Rate Logs', style: TextStyle(fontWeight: FontWeight.w300, fontFamily: "Roboto", color: Colors.white),),
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
                          
                          itemCount: titless.length,
                          itemBuilder: (context, index) {
                            return Card(                           
                              child: ListTile(
                                title: Text("Heart Rate: "+titless[index]["heartrate"]+"\n"+"Date: "+titless[index]["date"]+"\n"+"Time: "+titless[index]["time"]),
                                onTap: (){
                                  /* if((intent=="question" && abc[index]=="Mars")||(intent=="news" && abc[index]=="Mars"))
                                    _launcher();
                                  if((intent=="recipe" && abc[index]=="Mars")||(intent=="music" && abc[index]=="Mars"))
                                    Navigator.pushNamed(context, '/custom'); */
                                },
                              ),
                            );
                          },
                        ),
                    ),
                  ]
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
}