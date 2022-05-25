import 'package:flutter/material.dart';
class Option with ChangeNotifier{
  int optionId;
  String optionTitle;

  int marks;

  Option({ this.optionId,
     this.marks,this.optionTitle});
}