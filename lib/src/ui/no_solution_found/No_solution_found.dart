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
import 'package:ml_text_recognition/src/blocs/movies_detail_bloc.dart';
import 'package:ml_text_recognition/src/blocs/question_detail_bloc.dart';
import 'package:ml_text_recognition/src/model/movie_detail_model.dart';
import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/model/question_list.dart';
import 'package:ml_text_recognition/src/resources/api_provider.dart';
import 'package:ml_text_recognition/src/resources/repository.dart';
import 'package:ml_text_recognition/src/utils/my_scroll_behavior.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart';
import 'dart:math' show pi;

class NoSolution extends StatefulWidget {

  final String _text;

  NoSolution(this._text);

  @override
  _NoSolutionState createState() => _NoSolutionState();
}

class _NoSolutionState extends State<NoSolution> {
  Client client = Client();

  String _text = "";
  String apiResult;
  String body;
  QuestionDetailBloc question;

  @override
  void initState() {

  }



  @override
  Widget build(BuildContext context) {
    questionDetailBloc.searchQuestion(widget._text);
    return Scaffold(
        appBar: AppBar(

          title: Text("Question Submitted"),
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
              splashColor: Colors.transparent,
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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Your question will be solved in 24 hours.', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                  Text('We will notify you once the solution is ready! ', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)
                ],
              ),
              Image.asset("assets/images/commerce3x.png",height: 50,width: 50,),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(

              color: Colors.transparent,
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      )
                  ),
                  child: new Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: new Text('View Similar Question', style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                ),

                                child:StreamBuilder(
                                  stream: questionDetailBloc.questionDetail,
                                  builder: (context, AsyncSnapshot<QuestionList> snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data.toString());

                                      return  Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                          ),

                                          child:Text(snapshot.data.question_list[1].title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }

                                    return Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Center(child: CircularProgressIndicator()));
                                  },

                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                ),

                                child:StreamBuilder(
                                  stream: questionDetailBloc.questionDetail,
                                  builder: (context, AsyncSnapshot<QuestionList> snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data.toString());

                                      return  Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                          ),

                                          child:Text(snapshot.data.question_list[2].title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }

                                    return Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Center(child: CircularProgressIndicator()));
                                  },

                                ),
                              ),
                            )
                          ],

                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                ),

                                child:StreamBuilder(
                                  stream: questionDetailBloc.questionDetail,
                                  builder: (context, AsyncSnapshot<QuestionList> snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data.toString());

                                      return  Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                          ),

                                          child:Text(snapshot.data.question_list[3].title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }

                                    return Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Center(child: CircularProgressIndicator()));
                                  },

                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                ),

                                child:StreamBuilder(
                                  stream: questionDetailBloc.questionDetail,
                                  builder: (context, AsyncSnapshot<QuestionList> snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data.toString());

                                      return  Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                                          ),

                                          child:Text(snapshot.data.question_list[4].title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }

                                    return Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Center(child: CircularProgressIndicator()));
                                  },

                                ),
                              ),
                            )
                          ],

                        ),
                      ],
                    ),

                  )
              ),
            ),
          ),

        ],
      ),
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
