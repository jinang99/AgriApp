import 'package:flutter/material.dart';
import 'package:textts/add_marker.dart';
import 'package:textts/home.dart';
import 'package:textts/maps.dart';


class Option extends StatelessWidget{


  // Widget build(BuildContext context)
  // {
  //   return Scaffold(
  //       appBar: AppBar(
  //       title: Text('Options'),
  //   ) , 
  //   body: Center(
      
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //       RaisedButton(onPressed: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  //       },
  //         child: Text('Audio Schemes'),
  //       ),
  //       RaisedButton(
  //         onPressed: () {},   
  //         child: Text('Maps'),
  //         )
  //     ]
  //     ),
  //   )
  //   );

    
  // }
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
               // 
                Tab(icon: Icon(Icons.surround_sound)),
                Tab(icon: Icon(Icons.pin_drop)),
                Tab(icon: Icon(Icons.map)),
                //Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Features'),
          ),
          body: TabBarView(
            children: [
             //
              Home(),
             AddMarker(),
            MapHome(),
            ],
          ),
        ),
      ),
    );
  }


  
}


