
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:ml_text_recognition/src/model/question.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart';

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


  @override
  void initState() {
    _croppedImage = null;
    _text = "";
    _cropImage();
  }


  _cropImage() async {

    File croppedFile = await ImageCropper.cropImage(
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
      setState(() {
        _croppedImage = croppedFile;
      });
    }
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
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: MediaQuery.of(context).size.height / 2 ,
            elevation: 10,
            flexibleSpace: FlexibleSpaceBar(
              background: _croppedImage == null ? Container()
                  : Padding(
                    padding: const EdgeInsets.only(top: 40.0,left: 10.0,right: 10.0),
                    child: Image.file(_croppedImage,fit: BoxFit.contain),
                  ),
            ),
          ),
          SliverFillRemaining(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white.withOpacity(0.2),Colors.orangeAccent.withOpacity(0.6)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                      )
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Detected Text'),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60,left: 10,right: 10,bottom: 20),
                        child: SelectableText(
                          _text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.2
                          ),
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.directions_run,
                      ),
                      iconSize: 50,
                      color: Colors.green,
                      splashColor: Colors.pink,
                      onPressed: () {

                        searchQuestion(_text);

                      },
                    ),

                    Text('Press me to hit API'),
                    SizedBox(
                      width: 100.0,
                      height: 50.0,
                      //child: const Card(child: Text('  Hello World!')),
                    ),

                    Text(apiResult),
                  ],
                ),
              ],
            )
          ),

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

}
