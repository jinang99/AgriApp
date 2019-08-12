
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'place_detail.dart';
import 'package:firebase_database/firebase_database.dart';

const kGoogleApiKey = "AIzaSyCbdgLq_pjF9jgNxFS4umaVen9UFBLJoI4";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);


class AddMarker extends StatefulWidget {
  @override
  _AddMarkerState createState() => _AddMarkerState();
}

class _AddMarkerState extends State<AddMarker> {
  double lat_current ;
  double lng_current;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final databaseReference = FirebaseDatabase.instance.reference();
   List<DropdownMenuItem<int>> typeList = [];
   int _selectedType;
   void loadGenderList() {
    typeList = [];
    typeList.add(new DropdownMenuItem(
      child: new Text('Farmer'),
      value: 0,
    ));
    typeList.add(new DropdownMenuItem(
      child: new Text('Warehouse'),
      value: 1,
    ));
    typeList.add(new DropdownMenuItem(
      child: new Text('Shop'),
      value: 2,
    ));
  }
  
   @override
  Widget build(BuildContext context) {
    loadGenderList();
    return Scaffold(
      
    body: Form(
      
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        )));
  }
  
  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

  formWidget.add(new DropdownButton(
      hint: new Text('Select Type'),
      items: typeList,
      value: _selectedType,
      onChanged: (value) {
        setState(() {
          _selectedType = value;
        });
      },
      isExpanded: true,
    ),
   
    );
    formWidget.add(
       new RaisedButton(
      onPressed: inputData,
      child: Text('Add Marker'),
    )
    );
    
    return formWidget;
  }





 
  //   TextEditingController _textFieldController = TextEditingController();
  //   TextEditingController _textFieldController1 = TextEditingController();
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar:AppBar(title: Text( 'Retrieve Text Input') ,),
    
  //     body: Form(
  //       key: _formKey,
  //       child: Column(children: <Widget>[
  //           TextField(
  //           controller: _textFieldController,
  //           //Allow TextFiled take in Numbers as default
  //           keyboardType: TextInputType.number,
            
  //         ),
  //          TextField(
  //           controller: _textFieldController1,
  //           //Allow TextFiled take in Numbers as default
  //           keyboardType: TextInputType.number,
            
  //         ),
        
  //         // TextFormField(
  //         //   validator: (input) {
  //         //     if(input.isEmpty){
  //         //       return 'Please type email';
  //         //     }
  //         //   },
  //         //     onSaved: (input) => _email = input,
  //         //     decoration: InputDecoration(
  //         //       labelText: 'Email'
  //         //     ),
          
  //         // ),
  //         // TextFormField(
  //         //   validator: (input) {
  //         //     if(input.isEmpty ){
  //         //       return 'Please type password';
  //         //     }
  //         //   },
  //         //     onSaved: (input) => _password = input,
  //         //     decoration: InputDecoration(
  //         //       labelText: 'Password'
  //         //     ),
  //         //     obscureText: true,
  //         // ),
  //          RaisedButton(
  //           onPressed: inputData,
  //           child: Text('Add Marker'),
  //         )
  //       ],),
  //     )
  //   );
  // }

  void inputData() async {
    // print('oye');
    // print(_textFieldController.value.);
   await getUserLocation();
    print('check');
    print(lat_current);
    print(lng_current);
    databaseReference.child('markers').push().set({
      'lat': lat_current.toString(),
      'lng': lng_current.toString(),
      'desc': _selectedType,
      // 'lat': _textFieldController.value.text,
      // 'lng': _textFieldController1.value.text
    });
    
  }
    Future<void> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
       lat_current = currentLocation["latitude"];
      lng_current = currentLocation["longitude"];
      print(lat_current);
      print(lng_current);
      // final center = LatLng(lat, lng);
      // return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  

  


// Define a custom Form widget.


// Define a corresponding State class.
// This class holds the data related to the Form.

  }



  