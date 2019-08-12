import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:textts/SignIn/signin.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp>{
  @override
 String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dont have an Account? Create one'),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            validator: (input) {
              if(input.isEmpty){
                return 'Please type email';
              }
            },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
          
          ),
          TextFormField(
            validator: (input) {
              if(input.isEmpty ){
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
            child: Text('Sign Up'),
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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password );
       // user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      
    }
    catch(e){
      print(e.message);
    }
  }
}