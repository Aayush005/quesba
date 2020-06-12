import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:http/http.dart' show Client;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ml_text_recognition/src/blocs/question_detail_bloc.dart';
import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/model/question_list.dart';
import 'package:ml_text_recognition/src/resources/api_provider.dart';
import 'package:ml_text_recognition/src/resources/repository.dart';
import 'package:ml_text_recognition/src/utils/my_scroll_behavior.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart';
import 'dart:math' show pi;

class ShowSolution extends StatefulWidget {
  final File croppedImage;

  ShowSolution(this.croppedImage);

  @override
  _ShowSolutionState createState() => _ShowSolutionState();
}

class _ShowSolutionState extends State<ShowSolution> {
  Client client = Client();

  String _text = "";
  String apiResult;
  String body;
  QuestionDetailBloc question;

  @override
  void initState() {
    if (widget.croppedImage != null) {
      _readText(widget.croppedImage);
    }
  }

  _readText(image) async {
    var tempText;

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
    questionDetailBloc.searchQuestion(_text);
    return Scaffold(
        appBar: AppBar(
          title: Text("Solution"),
          leading: GestureDetector(
            onTap: () {/* Write listener code here */},
            child: Icon(
              Icons.arrow_back_ios, // add custom icons also
            ),
          ),
        ),
        body: LayoutBuilder(
          builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: _buildBody(context)
              ),
            );
          },
        )
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Container(
      height: 100,
      color: Color(0xFF3a70b9),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 40, 0, 0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              iconSize: 30,
              color: Colors.white,
              splashColor: Colors.pinkAccent,
              onPressed: () {},
            ),
            Text(
              'Solutiion',
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: questionDetailBloc.questionDetail,
          builder: (context, AsyncSnapshot<QuestionList> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.toString());
              return Text(snapshot.data.question_list[0].title,style: TextStyle(fontWeight: FontWeight.bold),);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Container(
                padding: EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()));
          },

        ),

        Transform.rotate(
          angle: 270 * pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: null,
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 300, 0),
          child: Image.asset("assets/images/Answer3x.png",width: 50,),
        ),

        StreamBuilder(
          stream: questionDetailBloc.questionDetail,
          builder: (context, AsyncSnapshot<QuestionList> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.toString());
              var x = snapshot.data.question_list[0].description;
              return  Html(
                data: x,
                //Optional parameters:
                style: {
                  "html": Style(
                    backgroundColor: Colors.black12,
//              color: Colors.white,
                  ),
//            "h1": Style(
//              textAlign: TextAlign.center,
//            ),
                  "table": Style(
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  "tr": Style(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  "th": Style(
                    padding: EdgeInsets.all(6),
                    backgroundColor: Colors.grey,
                  ),
                  "td": Style(
                    padding: EdgeInsets.all(6),
                  ),
                  "var": Style(fontFamily: 'serif'),
                },
                customRender: {
                  "flutter": (RenderContext context, Widget child, attributes, _) {
                    return FlutterLogo(
                      style: (attributes['horizontal'] != null)
                          ? FlutterLogoStyle.horizontal
                          : FlutterLogoStyle.markOnly,
                      textColor: context.style.color,
                      size: context.style.fontSize.size * 5,
                    );
                  },
                },
                onLinkTap: (url) {
                  print("Opening $url...");
                },
                onImageTap: (src) {
                  print(src);
                },
                onImageError: (exception, stackTrace) {
                  print(exception);
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Container(
                padding: EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()));
          },

        ),
      ],
    );
  }

  Widget buildContent(
      AsyncSnapshot<QuestionModel> snapshot, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(snapshot.data.title),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(snapshot.data.description),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
