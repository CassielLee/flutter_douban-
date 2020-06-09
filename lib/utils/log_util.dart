// import 'package:flutter/services.dart';

class Logger {
  static const DEFAULT_TAG = 'Flutter';

  // static void v(String msg,{String tag:DEFAULT_TAG}){

  // }

  static void d(String msg, {String tag: DEFAULT_TAG}) {
    print("$tag===$msg");
  }
}
