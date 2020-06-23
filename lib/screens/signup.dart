import 'dart:convert';
import 'package:chuify/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name1, name2, email, mobile, password;
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
      save();
    }
  }

  save() async {
    final response = await http
        .post("http://website/flutter_app/api_verification.php", body: {
      "flag": 2.toString(),
      "name1": name1,
      "name2": name2,
      "email": email,
      "mobile": mobile,
      "password": password,
      "fcm_token": "test_fcm_token"
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      print(message);
      registerToast(message);
    } else if (value == 2) {
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
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
                          "Registration Page",
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      //card for First name TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert first Name";
                            }
                          },
                          onSaved: (e) => name1 = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Enter Your First Name"),
                              
                        ),
                      ),

                       //card for Second name TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Second Name";
                            }
                          },
                          onSaved: (e) => name1 = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Enter Your Second Name"),
                              
                        ),
                      ),
                    
                      //card for Mobile TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Mobile Number";
                            }
                          },
                          onSaved: (e) => mobile = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phone, color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Enter Your Mobile",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      //card for United Arabs Emirates
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Select your country";
                            }
                          },
                          onSaved: (e) => mobile = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.language, color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "United Arab Emirates",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),


                      //card for Password TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          obscureText: _secureText,
                          onSaved: (e) => password = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phonelink_lock,
                                    color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Enter Your Password"),
                        ),
                      ),

                      //card for Email TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Email";
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
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.email, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Email (optional)"),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(12.0),
                      ),

                      SizedBox(
                        height: 44.0,
                        width: 500.0,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(
                              "Register",
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
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(
                              "Cancle",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            textColor: Colors.white,
                            color: Color(0xFFC0C0C0),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            }),
                      ),
                      SizedBox(height: 15.0),
                      SizedBox(
                        height: 50,
                        child: Text(
                          "Already have an Account? Login Now",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                      SizedBox(
                        height: 25,
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
  }
}
