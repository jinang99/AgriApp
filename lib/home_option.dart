import 'package:flutter/material.dart';
import 'package:textts/SignIn/signin.dart';
import 'package:textts/home.dart';
import 'package:textts/options.dart';
import 'package:textts/signup.dart';

 class HomeOption extends StatelessWidget {
     @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Sign In'),
                Tab(text: 'Sign Up'),
                // Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Farmie Normie'),
          ),
          body: TabBarView(
            children: [
              LoginPage(),
              SignUp(),
              //Icon(Icons.directions_transit),
              // Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
//   @override
//   Widget build(BuildContext context)
//   {
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('Options'),
//     ) , 
//     body: 
//       Center (
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         //crossAxisAlignment: CrossAxisAlignment.center,
//        // mainAxisSize: ,
//         children: <Widget>[
       
//         RaisedButton(onPressed: () {
//      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//   },
//           child: Text('Sign In'),
//           ),
//          RaisedButton(
//           onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
//           },   
//           child: Text('Sign Up'),
//           )
//       ]
//       ),
//     )
//     )
//     ;

    
//   }
}