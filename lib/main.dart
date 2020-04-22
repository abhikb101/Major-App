import 'formm.dart';
import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Homepage.dart';
import 'MyHomePage.dart';
import 'YoutubeCustomWidget.dart';
import 'Reminder.dart';
import 'tempr.dart';
import 'hrate.dart';
import 'userd.dart';
import 'userdetails.dart';

bool con_status = true;
var videoid;


void main(){ 
  
  runApp(       
     MaterialApp(
        theme: ThemeData(
          fontFamily: "Monospace",
          appBarTheme: AppBarTheme(elevation: 5.0, color:Colors.white)),
        title: 'Bot App',                      
        routes: <String, WidgetBuilder>{
          "/":(context)=>Userd(),
          '/userd':(context)=>UsedDetails(),
          "/dashboard":(context)=>Dashboard(),
          "/MyHomePage":(context)=>MyHomePage(),
          "/SosForm":(context)=>Formm(),
          "/custom":(context)=>YoutubeCustomWidget(videoid),
          "/Medicine_Reminder":(context)=>Reminder(),
          "/tempp":(context)=>Temp(),
          "/hrate":(context)=>Hrate(),
          "/Homepage":(context)=>Homepage(),

        },
        onGenerateRoute: (RouteSettings settings){
          switch(settings.name){
            case '/userd':
              return MaterialPageRoute(builder:(context)=>UsedDetails());
              break;
            case '/': 
              return MaterialPageRoute(builder: (context)=>Userd());
              break;
            case '/dashboard':
              return MaterialPageRoute(builder: (context)=>Dashboard());
            //case '/controller':
              //return MaterialPageRoute(builder: (context)=>Controller());
              break;
            case '/MyHomePage': 
              return MaterialPageRoute(builder: (context)=>MyHomePage());
              break;
            case '/SosForm':
              return MaterialPageRoute(builder: (context)=>Formm());
              break;
            case '/Medicine_Reminder':
              return MaterialPageRoute(builder: (context)=>Reminder());
              break;
            case '/tempp':
              return MaterialPageRoute(builder: (context)=>Temp());
              break;
             case '/hrate':
              return MaterialPageRoute(builder: (context)=>Hrate());
              break;
            case '/Homepage':
              return MaterialPageRoute(builder: (context)=>Homepage());
              break;
            default: return MaterialPageRoute(builder: (context)=>Homepage());
          }
        },
      )
  );
}