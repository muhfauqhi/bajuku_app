import 'package:bajuku_app/services/auth.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bajuku_app/shared/constants.dart';
import 'package:hexcolor/hexcolor.dart';

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
  bool _obscureText = true;

  //text field state
  String email = '';
  String password = '';
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
          onPressed: (){},
        ),
        title: 
        Text('Login',
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
              _buildEmailTextField(),
              _buildPasswordTextField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Forgot your password?', style: TextStyle(
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
                      
                    },
                  ),
                ],
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 14.0
                  ),
              ),
              RaisedButton(
                color: Hexcolor('#23414E'),
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Hexcolor('#E7C8AF')),
                ),
                padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Not a user yet?', style: TextStyle(
                    color: Hexcolor('#859289'),
                    ),
                  ),
                FlatButton(
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      color: Hexcolor('#4AA081'),
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
      decoration: textInputDecoration.copyWith(labelText: 'Password',
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
      decoration: textInputDecoration.copyWith(labelText: 'Email'),
      onChanged: (val){
        setState(() => email = val);
      },
    );
  }
}
