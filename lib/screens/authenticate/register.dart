import 'package:bajuku_app/screens/page/onboarding_login.dart';
import 'package:bajuku_app/services/auth.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bajuku_app/shared/constants.dart';
import 'package:hexcolor/hexcolor.dart';

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
  bool _obscureText = true;

  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Hexcolor('#3F4D55'),
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new OnboardLogin())
                  );
          },
        ),
        title: 
        Text('Register',
          style: TextStyle(color: Hexcolor('#3F4D55'),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildFirstNameTextField(),
              _buildLastNameTextField(),
              _buildEmailTextField(),
              _buildPasswordTextField(),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 14.0
                  ),
              ),
              RaisedButton(
                color: Hexcolor('#E7C8AF'),
                child: Text(
                  'Create an Account',
                  style: TextStyle(color: Hexcolor('#23414E')),
                ),
                padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password, firstName, lastName);
                    if(result == null){
                      setState(() {
                        error = 'Email not valid!';
                        loading =  false;
                      });
                    }
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Already an User?', style: TextStyle(
                    color: Hexcolor('#859289'),
                    ),
                  ),
                FlatButton(
                  child: Text(
                    'Come this way',
                    style: TextStyle(
                      color: Hexcolor('#E1B359'),
                    ),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  TextFormField _buildPasswordTextField() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(
        labelText: 'Password',
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              _obscureText = !_obscureText;
            });
          }, 
          icon: Icon(Icons.remove_red_eye),
          color: Hexcolor('#3F4D55'),
          ),
        ),
      obscureText: _obscureText,
      onChanged: (val){
        setState(() => password = val);
      },
    );
  }

  TextFormField _buildEmailTextField() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(
        labelText: 'Email',
      ),
      onChanged: (val){
        setState(() => email = val);
      },
    );
  }

  TextFormField _buildFirstNameTextField() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(
        labelText: 'First Name'),
      onChanged: (val){
        setState(() => firstName = val);
      },
    );
  }

  TextFormField _buildLastNameTextField() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(
        labelText: 'Last Name',
        ),
      onChanged: (val){
        setState(() => lastName = val);
      },
    );
  }
}

