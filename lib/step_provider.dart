import 'package:flutter/material.dart';
import "package:provider/provider.dart";

List <Color> colors = [Colors.green, Colors.orange, Colors.grey];
class StepperState extends ChangeNotifier {
  int _current = 0;
  List <Color> _colors = colors;
  int get current => _current;
  List <Color> get dcolors => _colors;

  void change(int updated){
    _current = updated;
    notifyListeners();
  }


}