
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' show Client;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/ui/show_solution/show_solution.dart';
import 'package:ml_text_recognition/src/ui/solution_found/solution_found.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart';
import 'package:ml_text_recognition/src/ui/no_solution_found/No_solution_found.dart';

class MLPage extends StatefulWidget {

  final String imageFile;

  MLPage(this.imageFile);

  @override
  _MLPageState createState() => _MLPageState();
}

class _MLPageState extends State<MLPage> {
  Client client = Client();

  File _croppedImage;
  String _text,apiResult = "";
  String body;
  File croppedFile;

  @override
  void initState() {
    _croppedImage = null;
    _text = "";
    _cropImage();
  }


  _cropImage() async {

    croppedFile = await ImageCropper.cropImage(
      sourcePath: widget.imageFile,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop XD',
          statusBarColor: Colors.blue,
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          cropFrameColor: Colors.blue,

      ),
    );

    if (croppedFile != null) {
      _readText(croppedFile);

  }

  }

  _showSolutionFound(){

    _readText(croppedFile);
    setState(() {
      _croppedImage = croppedFile;
    });
  }

  _readText(image) async {
    var tempText = "";

    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(image);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();

    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          tempText = tempText + " " + word.text;
        }
        tempText = tempText + '\n';
      }
      tempText = tempText + '\n';
    }

    setState(() {
      _text = tempText;
      searchQuestion(_text);

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[

        ],
      ),
    );
  }

  Future<QuestionModel> searchQuestion(String type) async {



    final response = await client.post('http://apitesting.quesba.com/question/Search',headers: { "x-api-key":"e67c01f9-263b-47cb-a249-bf09067c9e68","Content-Type":"application/json"}, body: json.encode(type));

    print("Test Api");
    print(response.request.url);
    print(response.body.toString());
    print("End Test");

    if (response.statusCode == 200) {
      setState(() {
        apiResult = response.body.toString();
        if(apiResult.toString().length>=10) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SolutionFound(croppedFile)));
        }else{
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => NoSolution(type)));
        }
    });

    } else {
      throw Exception('Failed to load post');
    }
  }

}
