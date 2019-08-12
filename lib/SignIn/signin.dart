import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../home.dart';
import '../options.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in to your Account'),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            validator: (input) => input.isEmpty? 'Please specify email' : null,
            
            
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
          
          ),
          TextFormField(
            validator: (input) {
              if(input.length < 6){
                return 'Please type password';
              }
            },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
          ),
          RaisedButton(
            onPressed: signIn,
            child: Text('Sign In'),
          )
        ],),
      )
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
     
    }
    try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password );
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => Option()));
      
    }
    catch(e){
      print(e.message);
    }
  }

}