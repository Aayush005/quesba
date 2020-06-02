import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ml_text_recognition/main.dart';
import 'package:ml_text_recognition/src/model/user_model.dart';
import 'package:ml_text_recognition/src/ui/login/signin_scren.dart';

class HomeSetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInOne(),
//    body: SignInTwo(),
    );
  }
}

