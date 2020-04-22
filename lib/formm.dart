import 'Homepage.dart';
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userd.dart';

class Formm extends StatefulWidget {
  @override
  _FormmState createState() => _FormmState();
}


class _Datatwo {
  String name = '';
  String mobno = '' ;
  String eid = '';
  String rel = '';
}

class _FormmState extends State<Formm> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();


  _Datatwo _data2 = new _Datatwo();

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {

      return 'The E-mail Address must be a valid email address.';
    }

    return null;
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
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Form Submission"),  
    content: Text("Thank you for filling the form !"),  
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

  void submit() async{

        

    if (this._formKey1.currentState.validate()) {

      _formKey1.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Name: ${_data2.name}');
      print('Mobile number: ${_data2.mobno}');
      print('Email id: ${_data2.eid}');
      print('Relation: ${_data2.rel}');

      

    var details = (_data2.name+","+_data2.mobno+","+_data2.eid+","+_data2.rel);     
    
    var aaaa =  {"sos":details};
    var bbbb = jsonEncode(aaaa);
    http.Response response = await  http.put(
      Uri.encodeFull("https://majormars.herokuapp.com/user/update/"+maindata.userid.toString()), 
      body:bbbb ,  
      headers: {"Content-Type": "application/json"}

    );
      
      print(response.body);

      
      _formKey1.currentState.reset();

      showAlertDialog(context);

    }
    

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      bottom: PreferredSize(
            preferredSize: Size.fromHeight(175),
            child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(alignment:Alignment.bottomLeft, child:Text(
                      'SOS FORM',
                      style: TextStyle(fontWeight: FontWeight.w400,fontFamily:"Monospace",color: Colors.white, fontSize: 55),
                    )),
                  )
                ),
        backgroundColor: Colors.red,
      ),
      
      body: Container(
        child:SingleChildScrollView(
        child:Column(
          children: <Widget>[
             const SizedBox(height: 16.0),
             Text('Emergency Contact Details',textAlign:TextAlign.center),
              Form(
                key: _formKey1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50,50,50,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter the person name',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                            this._data2.name = value;
                          }
                      ),
                     
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Enter person mobile number',
                        ),
                        validator: _validateMobile,
                        onSaved: (String value) {
                            this._data2.mobno = value;
                          }
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Enter person email id',
                        ),
                        validator: this._validateEmail,
                        onSaved: (String value) {
                          this._data2.eid = value;
                        }
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter Relation',
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Relation is required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          this._data2.rel = value;
                        }
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Row(
                        children: <Widget>[
                          const Spacer(),
                          OutlineButton(
                            highlightedBorderColor: Colors.black,
                            onPressed: this.submit,
                            
                            child: const Text('Submit'), 
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          
          ],
        ),
        ),
      ),
    );
  }

  


}




/*
final myController = TextEditingController();
  var name,email,mobno;


  final _formKey = GlobalKey<FormState>();
  
  _onSubmit(){
    setState(() {
       
    });
  }

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[

            TextFormField(
              focusNode: nodeOne,
              autofocus: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: myController,
            
              decoration: InputDecoration(
                labelText:'Enter Name'
              ),
            ),

            name = Text(myController.text),

            TextFormField(
              focusNode: nodeTwo,
              controller: myController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText:'Enter Mobile number'
              ),
            ),

            mobno = Text(myController.text),

            TextFormField(
              focusNode: nodeThree,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }, 
              controller: myController,
              decoration: InputDecoration(
                labelText:'Enter Email'
              ),
            ),
            
            email = Text(myController.text),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        )
      )
    );
  }*/