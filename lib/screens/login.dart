import 'dart:convert';

import 'package:chuify/screens/main-menu.dart';
import 'package:chuify/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http
        .post("http://website/flutter_app/api_verification.php", body: {
      "flag": 1.toString(),
      "email": email,
      "password": password,
      "fcm_token": "test_fcm_token"
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String id = data['id'];

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, nameAPI, id);
      });
      print(message);
      loginToast(message);
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  savePref(int value, String email, String name, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);

      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        bool isChecked;
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
//            color: Colors.grey.withAlpha(20),
                    color: Colors.black,
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Image.asset('images/logo.png'),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 50,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.0),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),

                          //card for Email TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please Insert Email";
                                }
                              },
                              onSaved: (e) => email = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child:
                                        Icon(Icons.person, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Email"),
                            ),
                          ),

                          // Card for password TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Password Can't be Empty";
                                }
                              },
                              obscureText: _secureText,
                              onSaved: (e) => password = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.phonelink_lock,
                                      color: Colors.black),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                contentPadding: EdgeInsets.all(18),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          
                          FlatButton(
                            onPressed: null,
                            child: Text(
                              "Remeber Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(5.0),
                          ),

                          SizedBox(
                            height: 44.0,
                            width: 500.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0)),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                textColor: Colors.white,
                                color: Color(0xFFFFA500),
                                onPressed: () {
                                  check();
                                }),
                          ),
                          SizedBox(height: 15.0),
                          SizedBox(
                            height: 44.0,
                            width: 500.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0)),
                                child: Text(
                                  "NOT A MEMEBER? SIGNUP NOW!",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                textColor: Colors.white,
                                color: Color(0xFFC0C0C0),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                  );
                                }),
                          ),
                          SizedBox(height: 15.0),
                      SizedBox(
                        height: 50,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;

      case LoginStatus.signIn:
        return MainMenu(signOut);
//        return ProfilePage(signOut);
        break;
    }
  }
}
