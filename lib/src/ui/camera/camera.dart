import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/model/question_list.dart';
import 'package:ml_text_recognition/src/ui/camera/DarwinCamera.dart';
import 'package:ml_text_recognition/src/ui/camera/dimensions.dart';
import 'package:ml_text_recognition/src/ui/camera/helper.dart';
import 'dart:async';
import 'package:ml_text_recognition/src/blocs/question_detail_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DarwinCameraTutorial(),
      ),
    );
  }
}

class DarwinCameraTutorial extends StatefulWidget {
  const DarwinCameraTutorial({Key key}) : super(key: key);

  @override
  _DarwinCameraTutorialState createState() => _DarwinCameraTutorialState();
}

class _DarwinCameraTutorialState extends State<DarwinCameraTutorial> {
  File imageFile;
  bool isImageCaptured;
  var controllerSearch = TextEditingController();
  Client client = Client();
  var _text;

  @override
  void initState() {
    super.initState();

    isImageCaptured = false;
  }

  openCamera(BuildContext context) async {
    PermissionHandler permissionHandler = PermissionHandler();

    await checkForPermissionBasedOnPermissionGroup(
      permissionHandler,
      PermissionGroup.camera,
    );

    ///
    /// Microphone permission is required for android devices.
    /// if permission isn't given before opening camera.
    /// The app will crash.
    ///
    /// For iOS devices, it's not neccessary. You can skip microphone permission.
    /// Required for android devices.
    await checkForPermissionBasedOnPermissionGroup(
      permissionHandler,
      PermissionGroup.microphone,
    );

    ///
    String filePath = await FileUtils.getDefaultFilePath();
    String uuid = DateTime.now().millisecondsSinceEpoch.toString();

    ///
    filePath = '$filePath/$uuid.png';

    List<CameraDescription> cameraDescription = await availableCameras();

    ////
    DarwinCameraResult result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DarwinCamera(
          cameraDescription: cameraDescription,
          filePath: filePath,
          resolution: ResolutionPreset.high,
          defaultToFrontFacing: false,
          quality: 100,
        ),
      ),
    );

    ///
    ///
    if (result != null && result.isFileAvailable) {
      setState(() {
        isImageCaptured = true;
        imageFile = result.file;
      });
      print(result.file);
      print(result.file.path);
    }

    ///
  }

  String apiResult = "";

  Future<QuestionModel> searchQuestion(String type) async {


    print("Test Api start");
    final response = await client.post('http://apitesting.quesba.com/question/getSimilarquestionsfromtext',headers: { "x-api-key":"e67c01f9-263b-47cb-a249-bf09067c9e68","Content-Type":"application/json"}, body: json.encode(type));

    print("Test Api");
    print(response.request.url);
    print(response.body.toString());
    print("End Test end");
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

  @override
  Widget build(BuildContext context) {
    questionDetailBloc.searchQuestion(_text);
    return Stack(
      children: <Widget>[
        FloatingSearchBar.builder(
          pinned: true,
          itemCount: 2,
          padding: EdgeInsets.only(top: 10.0),
          itemBuilder: (BuildContext context, int index) {
            return StreamBuilder(
              stream: questionDetailBloc.questionDetail,
              builder: (context, AsyncSnapshot<QuestionList> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.toString());
                  return Text(snapshot.data.question_list[index].title,style: TextStyle(fontWeight: FontWeight.bold),);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()));
              },

            );
          },
          trailing: Icon(Icons.notifications,),
          controller: controllerSearch,
          onChanged: (String value) {
            setState(() {
              _text = controllerSearch.text;
            });

          },
          onTap: () {},
          decoration: InputDecoration.collapsed(
            hintText: "  Type Your Question ...",
          ),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            SizedBox(
              height: 100,
            ),
            Stack(
              children: <Widget>[
                Image.asset(
                  "assets/LoginSignup/doodlebackground3x.png",
                  height: 500,
                  width: 500,
                ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                              onPressed: () {
                                openCamera(context);
                              },
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset(
                                'assets/LoginSignup/cameraclickhere3x.png',
                                height: 200,
                                width: 200,
                              )),
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
              height: 120.0,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/accounting@3x.png",

                      ),
                    ),

                  ),

                  SizedBox(width: 10,),
                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/ecnomics@3x.png",

                      ),
                    ),

                  ),

                  SizedBox(width: 10,),

                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/finance@3x.png",

                      ),
                    ),

                  ),

                  SizedBox(width: 10,),

                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/computer@3x.png",

                      ),
                    ),

                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/accounting@3x.png",

                      ),
                    ),

                  ),

                  SizedBox(width: 10,),
                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/ecnomics@3x.png",

                      ),
                    ),

                  ),

                  SizedBox(width: 10,),

                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/finance@3x.png",

                      ),
                    ),

                  ),

                  SizedBox(width: 10,),

                  Container(
                    width: 100.0,
                    height: 100,

                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      height: 25,
                      width: 25,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/LoginSignup/computer@3x.png",

                      ),
                    ),

                  ),
                  SizedBox(width: 10,),

                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<bool> checkForPermissionBasedOnPermissionGroup(
  PermissionHandler permissionHandler,
  PermissionGroup permissionType,
) async {
  ///
  PermissionStatus permission;
  permission = await permissionHandler.checkPermissionStatus(permissionType);
  if (permission == PermissionStatus.granted) {
    // takeImageFromCameraAndSave();
    return true;
  }
  var status = await permissionHandler.requestPermissions([permissionType]);
  permission = status[permissionType];

  if (permission == PermissionStatus.granted) {
    // takeImageFromCameraAndSave();
    return true;
  } else {
    ///
    /// ASK USER TO GO TO SETTINGS TO GIVE PERMISSION;

    return false;
  }
}

class FileUtils {
  static Future<String> getDefaultFilePath() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String mediaDirectory = appDocDir.path + "/media";
      Directory(mediaDirectory).create(recursive: true);
      return mediaDirectory;
    } catch (error, stacktrace) {
      print('could not create folder for media assets');
      print(error);
      print(stacktrace);
      return null;
    }
  }
}

class ButtonWithImage extends StatelessWidget {
  final Key key;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final Icon icon;
  final IconData iconData;
  final String title;

  ButtonWithImage({
    this.key,
    @required this.onTap,
    this.padding,
    this.icon,
    this.iconData,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(grid_spacer * 2),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Container(
            margin: margin_a_s,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colors.white,
                  size: grid_spacer * 5,
                ),
                SizedBox(
                  width: grid_spacer * 1.5,
                ),
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.display1.copyWith(
                        color: Colors.white,
                        height: 1.2,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}
