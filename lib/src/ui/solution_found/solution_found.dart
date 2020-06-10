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

 class SolutionFound extends StatefulWidget{

  final File croppedImage;

  SolutionFound(this.croppedImage);

  @override
  State<StatefulWidget> createState() {
    return _SolutionFoundState();
  }

}

class _SolutionFoundState extends State<SolutionFound>{


  String apiResult = "",apiResultSignUp="";
  Client client = Client();
  var _textController = TextEditingController();
  var _textController2 = TextEditingController();



  @override
  void initState() {


    if(widget.croppedImage!=null){
      Future.delayed(const Duration(milliseconds: 3000), () {

        setState(() {

          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSolution(widget.croppedImage)));        });

      });

    }

  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(

          child: Stack(
            children: <Widget>[
              Image.asset("assets/images/Group2002@3x.png"),
              Image.asset("assets/images/Group1991@3x.png"),

            ],
          ),
        ),


    );
  }

}