import 'dart:convert';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_text_recognition/main.dart';
import 'package:ml_text_recognition/ml.dart';
import 'package:ml_text_recognition/src/model/user_model.dart';
import 'package:http/http.dart' show Client;
import 'package:ml_text_recognition/src/ui/login/signin_scren.dart';

class SignUpOne extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUpOneState();
  }

}

class _SignUpOneState extends State<SignUpOne>{


  String apiResult = "",apiResultSignUp="";
  Client client = Client();
  var _textController = TextEditingController();
  var _textController2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset("assets/LoginSignup/logo.png"),
                SizedBox(
                  width: 50.0,
                  height: 75.0,

                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    color: Colors.white,
                    child: TextField(decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'USERNAME',
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),

                    ),
                      controller: _textController,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    color: Colors.white,
                    child: TextField(decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'EMAIL',
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),

                    ),
                      controller: _textController,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    color: Colors.white,

                    child: TextField(decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'CREATE PASSWORD',
                      suffixIcon: Icon(Icons.remove_red_eye),
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 0.0, top: 8.0),

                    ),
                      obscureText: true,
                      controller: _textController2,

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    color: Colors.white,

                    child: TextField(decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'CONFIRM PASSWORD',
                      suffixIcon: Icon(Icons.remove_red_eye),
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 0.0, top: 8.0),

                    ),
                      obscureText: true,
                      controller: _textController2,

                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: MaterialButton(
                    onPressed: (){

                      login(_textController.text,_textController2.text);

                      if(apiResultSignUp.length>10){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHome()),
                        );
                      }

                    },//since this is only a UI app
                    child: Text('SIGNUP',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SFUIDisplay',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Color(0xff3a70b9),
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: new RichText(
                      text: new TextSpan(text: 'Already have an account ', style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'SFUIDisplay',

                      ),
                          children: [
                            new TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: Color(0xff3a70b9),
                                fontSize: 15,
                                fontFamily: 'SFUIDisplay',

                              ),
                              recognizer: new TapGestureRecognizer()..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignInOne()),
                                );
                              },
                            )
                          ]),
                    ),
                  ),
                ),

                Text(apiResultSignUp),
                Text(apiResult),

              ],
            ),
          ],
        )
    );
  }

  Future<UserModel> login(String email,String pass) async {



    final response = await client.post('http://apitesting.quesba.com/user/login',headers: { "x-api-key":"e67c01f9-263b-47cb-a249-bf09067c9e68","Content-Type":"application/json"}, body: json.encode({
      "DomainId":1,
      "EmailId":email,
      "Password":pass
    }));

    print("Test Api");
    print(response.request.url);
    print(response.body.toString());
    print("End Test");
//    print(response.body.toString());
//    print(response.body.toString());
//    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        apiResult = response.body.toString();
      });

    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<UserModel> signUp(String email,String pass) async {

    final response = await client.post('http://apitesting.quesba.com/user/register',headers: { "x-api-key":"e67c01f9-263b-47cb-a249-bf09067c9e68","Content-Type":"application/json"}, body: json.encode({
      "DomainId":1,
      "EmailId":email,
      "Password":pass
    }));

    print("Test Api");
    print(response.request.url);
    print(response.body.toString());
    print("End Test");


    if (response.statusCode == 200) {
      setState(() {
        apiResultSignUp = response.body.toString();
      });

    } else {
      throw Exception('Failed to load post');
    }
  }

}