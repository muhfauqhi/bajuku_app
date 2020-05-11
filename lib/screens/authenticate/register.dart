import 'package:bajuku_app/services/auth.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bajuku_app/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
          child: Text('Sign up to Digidrobe',
            style: TextStyle(color: Colors.grey[900]),),
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
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 8 ? 'Enter a password minimum 8 characters!' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.grey[900],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Email not valid!';
                        loading =  false;
                      });
                    }
                  }
                }
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
                  'Already have account?',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
                onPressed: () {
                  widget.toggleView();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}