import 'package:bajuku_app/services/auth.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bajuku_app/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        title: 
        Center(
          child: Text('Sign in to Digidrobe',
            style: TextStyle(color: Colors.black)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.grey[900],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Email or Password not match!';
                        loading =  false;
                      });
                    }
                  }
                },
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 14.0
                  ),
              ),
              FlatButton(
                child: Text(
                  'Register?',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
                onPressed: () {
                  widget.toggleView();
                },
              )
            ]
          ),
        ),
      ),
    );
  }
}
