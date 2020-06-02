import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ml_text_recognition/ml.dart';
import 'package:ml_text_recognition/src/todo/crop/extendd_image_editor.dart';
import 'package:ml_text_recognition/src/todo/crop/extended_image.dart';
import 'package:ml_text_recognition/src/todo/crop/extended_image_utils.dart';
import 'package:ml_text_recognition/src/todo/crop/utils.dart';
import 'package:ml_text_recognition/src/todo/crop/extended_image_editor_utils.dart';
import 'package:ml_text_recognition/src/ui/camera/image_picker_io.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageEditorDemo extends StatefulWidget {

  final Uint8List imageFile;

  ImageEditorDemo(this.imageFile);

  @override
  _ImageEditorDemoState createState() => _ImageEditorDemoState();
}

class _ImageEditorDemoState extends State<ImageEditorDemo> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
  GlobalKey<ExtendedImageEditorState>();
  List<AspectRatioItem> _aspectRatios = List<AspectRatioItem>()
    ..add(AspectRatioItem(text: "custom", value: CropAspectRatios.custom))
    ..add(AspectRatioItem(text: "original", value: CropAspectRatios.original))
    ..add(AspectRatioItem(text: "1*1", value: CropAspectRatios.ratio1_1))
    ..add(AspectRatioItem(text: "4*3", value: CropAspectRatios.ratio4_3))
    ..add(AspectRatioItem(text: "3*4", value: CropAspectRatios.ratio3_4))
    ..add(AspectRatioItem(text: "16*9", value: CropAspectRatios.ratio16_9))
    ..add(AspectRatioItem(text: "9*16", value: CropAspectRatios.ratio9_16));
  AspectRatioItem _aspectRatio;
  bool _cropping = false;
  File file;

  @override
  void initState() {
    _aspectRatio = _aspectRatios.first;
    //var outputAsUint8List = new Uint8List.fromList(elements);
   // _getImage();
    print("Printing file in destnation");

    print(widget.imageFile);
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quesba"),
        backgroundColor: Colors.black,
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              if(widget.imageFile != null){
               // Navigator.push(context, MaterialPageRoute(builder: (context) => MLPage(widget.imageFile)));
              }
            },
          ),
        ],
      ),
      body: Center(

        child: widget.imageFile == null
            ?
        
        ExtendedImage.memory(widget.imageFile,

          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          enableLoadState: true,
          extendedImageEditorKey: editorKey,
          initEditorConfigHandler: (state) {
            return EditorConfig(
                maxScale: 8.0,
                cropRectPadding: EdgeInsets.all(20.0),
                hitTestSize: 20.0,
                initCropRectType: InitCropRectType.imageRect,
                cropAspectRatio: _aspectRatio.value);
          },
        )
            : Container(
              color: Colors.black,

              child: ExtendedImage.network(
          "https://www.fodors.com/wp-content/uploads/2019/04/01_IndiaAdventuresInMeghalaya__CrossingADouble-DeckerLivingRootBridge_1-shutterstock_1069408832-768x512.jpg",
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          extendedImageEditorKey: editorKey,
          initEditorConfigHandler: (state) {
              return EditorConfig(
                  maxScale: 8.0,
                  cropRectPadding: EdgeInsets.all(20.0),
                  hitTestSize: 20.0,
                  initCropRectType: InitCropRectType.imageRect,
                  cropAspectRatio: _aspectRatio.value);
          },
        ),
            ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        child: ButtonTheme(
          minWidth: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                onTap: () {
                  editorKey.currentState.reset();
                },
                child: new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child:
                  new Text('RESET', style: TextStyle(color: Colors.white)),
                ),
              ),

//              FlatButtonWithIcon(
//                icon: Icon(Icons.crop),
//                label: Text(
//                  "Crop",
//                  style: TextStyle(fontSize: 10.0),
//                ),
//                textColor: Colors.white,
//                onPressed: () {
//                  showModalBottomSheet(
//                      context: context,
//                      builder: (BuildContext context) {
//                        return Container(
//                          child: GridView.builder(
//                            gridDelegate:
//                                SliverGridDelegateWithFixedCrossAxisCount(
//                                    crossAxisCount: 3),
//                            padding: EdgeInsets.all(20.0),
//                            itemBuilder: (_, index) {
//                              var item = _aspectRatios[index];
//                              return GestureDetector(
//                                child: AspectRatioWidget(
//                                  aspectRatio: item.value,
//                                  aspectRatioS: item.text,
//                                  isSelected: item == _aspectRatio,
//                                ),
//                                onTap: () {
//                                  Navigator.pop(context);
//                                  setState(() {
//                                    _aspectRatio = item;
//                                  });
//                                },
//                              );
//                            },
//                            itemCount: _aspectRatios.length,
//                          ),
//                        );
//                      });
//                },
//              ),
//              FlatButtonWithIcon(
//                icon: Icon(Icons.flip),
//                label: Text(
//                  "Flip",
//                  style: TextStyle(fontSize: 10.0),
//                ),
//                textColor: Colors.white,
//                onPressed: () {
//                  editorKey.currentState.flip();
//                },
//              ),
              IconButton(
                icon: Icon(
                  Icons.rotate_left,
                ),
                color: Colors.white,
                onPressed: () {
                  editorKey.currentState.rotate(right: false);
                },
              ),


//              FlatButtonWithIcon(
//                icon: Icon(Icons.restore),
//                label: Text(
//                  "Reset",
//                  style: TextStyle(fontSize: 10.0),
//                ),
//                textColor: Colors.white,
//                onPressed: () {
//                  editorKey.currentState.reset();
//                },
//              ),

              InkWell(
                onTap: () {
                  editorKey.currentState.reset();
                },
                child: new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child:
                  new Text('DONE', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCropDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext content) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Material(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "select library to crop",
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Image",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decorationStyle:
                                          TextDecorationStyle.solid,
                                          decorationColor: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launch(
                                              "https://github.com/brendan-duncan/image");
                                        }),
                                  TextSpan(
                                      text:
                                      "(Dart library) for decoding/encoding image formats, and image processing. It's stable.")
                                ],
                              ),
                              TextSpan(text: "\n\n"),
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "ImageEditor",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decorationStyle:
                                          TextDecorationStyle.solid,
                                          decorationColor: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launch(
                                              "https://github.com/fluttercandies/flutter_image_editor");
                                        }),
                                  TextSpan(
                                      text:
                                      "(Native library) support android/ios, crop flip rotate. It's faster.")
                                ],
                              )
                            ])),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                OutlineButton(
                                  child: Text(
                                    'Dart',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                   // _cropImage(false);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                ),
                                OutlineButton(
                                  child: Text(
                                    'Native',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                   // _cropImage(true);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ))),
              Expanded(
                child: Container(),
              )
            ],
          );
        });
  }




  Future showBusyingDialog() async {
    var primaryColor = Theme.of(context).primaryColor;
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "cropping...",
                  style: TextStyle(color: primaryColor),
                )
              ],
            ),
          ),
        ));
  }
}
