import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'Dashboard.dart';
import 'Homepage.dart';

bool con_status = true;
bool test;
void main(){ 
  
  runApp(       
     MaterialApp(
        theme: ThemeData(appBarTheme: AppBarTheme(elevation: 5.0, color:Colors.white)),
        title: 'Bot App',                      
        routes: <String, WidgetBuilder>{
          "/":(context)=>Homepage(),
          "/dashboard":(context)=>Dashboard()
        },
        onGenerateRoute: (RouteSettings settings){
          switch(settings.name){
            case '/': 
              return MaterialPageRoute(builder: (context)=>Homepage());
              break;
            case '/dashboard':
              return MaterialPageRoute(builder: (context)=>Dashboard());
            //case '/controller':
              //return MaterialPageRoute(builder: (context)=>Controller());
              break;
            default: return MaterialPageRoute(builder: (context)=>Homepage());
          }
        },
      )
  );
}
