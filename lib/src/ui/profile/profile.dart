import 'dart:convert';
import 'dart:io';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_text_recognition/main.dart';
import 'package:ml_text_recognition/ml.dart';
import 'package:ml_text_recognition/src/model/user_model.dart';
import 'package:http/http.dart' show Client;
import 'package:ml_text_recognition/src/ui/login/signin_scren.dart';
import 'package:ml_text_recognition/src/ui/show_solution/show_solution.dart';

class Profile extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }

}

class _ProfileState extends State<Profile>{


  String apiResult = "",apiResultSignUp="";
  Client client = Client();
  var _textController = TextEditingController();
  var _textController2 = TextEditingController();



  @override
  void initState() {




  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(

        child: Stack(
          children: <Widget>[
            Text('History')

          ],
        ),
      ),


    );
  }

}