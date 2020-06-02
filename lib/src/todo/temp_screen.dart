import 'dart:convert';

import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_text_recognition/main.dart';
import 'package:ml_text_recognition/ml.dart';
import 'package:ml_text_recognition/src/model/user_model.dart';
import 'package:http/http.dart' show Client;

class Temp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TempState();
  }

}

class _TempState extends State<Temp>{



  Future pickImage(context,source) async {
    var tempFile = await ImagePicker.pickImage(
      source: source,
    );

    if(tempFile != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MLPage(tempFile.path)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: <Widget>[

            FloatingSearchBar.builder(
              pinned: true,
              itemCount: 0,
              padding: EdgeInsets.only(top: 10.0),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(index.toString()),
                );
              },
              trailing: Icon(Icons.notifications),

              onChanged: (String value) {},
              onTap: () {},
              decoration: InputDecoration.collapsed(
                hintText: "  Type Your Question ...",
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 100,),

                Stack(

                  children:<Widget>[
                    Image.asset("assets/LoginSignup/doodlebackground3x.png",height: 500,width: 500,),
                    Padding(
                      padding: EdgeInsets.fromLTRB(95, 110, 0, 0),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                  onPressed: (){

                                  pickImage(context,ImageSource.camera);

                                  },
                                  padding: EdgeInsets.all(0.0),
                                  child: Image.asset('assets/LoginSignup/cameraclickhere3x.png',height: 200,width: 200,)),

                            ),
                          ),

                          Text('Scan the Question to Get the Solution'),

                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 100.0,
                  child: new ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[


                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/accounting@3x.png"),),
                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/ecnomics@3x.png"),),
                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/finance@3x.png"),),
                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/computer@3x.png"),),
                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/accounting@3x.png"),),
                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/ecnomics@3x.png"),),
                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/finance@3x.png"),),
                      Container(width: 100.0,height: 100, child: Image.asset("assets/LoginSignup/computer@3x.png"),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}