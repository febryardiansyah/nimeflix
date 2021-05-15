import 'package:flutter/cupertino.dart';

class Helpers {
  static void requestNode(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
}