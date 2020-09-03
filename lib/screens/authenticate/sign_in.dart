import 'package:bajuku_app/services/auth.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bajuku_app/shared/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.arrow_back),
                color: Hexcolor('#3F4D55'),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => OnboardScreen()));
                },
              ),
              title: Text(
                'Login',
                style: TextStyle(
                  color: Hexcolor('#3F4D55'),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: <Widget>[
                          _buildEmailTextField(),
                          SizedBox(height: 30),
                          _buildPasswordTextField(),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: Hexcolor('#859289'),
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  'Come this way',
                                  style: TextStyle(
                                    color: Hexcolor('#E1B359'),
                                  ),
                                ),
                                onTap: () {
                                  print('aaa');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Email or Password not match!';
                              loading = false;
                            });
                          } else {
                            setState(() => loading = false);
                          }
                        }
                      },
                      child: Image(
                        image: AssetImage(
                          'assets/images/sign_in.png',
                        ),
                      ),
                    ),
                    // RaisedButton(
                    //   color: Hexcolor('#23414E'),
                    //   child: Text(
                    //     'Sign in',
                    //     style: TextStyle(color: Hexcolor('#E7C8AF')),
                    //   ),
                    //   padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
                    //   onPressed: () async {
                    //
                    // ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Not a user yet?',
                            style: TextStyle(
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
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  TextFormField _buildPasswordTextField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Password can\'t be empty!';
        }
        return null;
      },
      decoration: textInputDecoration.copyWith(
        labelText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(Icons.remove_red_eye),
          color: Hexcolor('#3F4D55'),
        ),
      ),
      obscureText: _obscureText,
      onChanged: (val) {
        setState(() => password = val);
      },
    );
  }

  TextFormField _buildEmailTextField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Email can\'t be empty!';
        }
        return null;
      },
      decoration: textInputDecoration.copyWith(labelText: 'Email'),
      onChanged: (val) {
        setState(() => email = val);
      },
    );
  }
}
