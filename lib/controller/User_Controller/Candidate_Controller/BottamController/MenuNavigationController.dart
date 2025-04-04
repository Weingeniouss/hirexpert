// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:hirexpert/view/screen/Candidate/Menu/Dashboard/dashboard.dart';

import '../../../../view/screen/Candidate/Menu/Home/Home.dart';
import '../../../../view/screen/Candidate/Menu/Search/Search.dart';
import '../../../../view/screen/Candidate/Menu/message/Message.dart';
import '../../../../view/screen/Candidate/Menu/profile/information.dart';

class MenuNavigationController with ChangeNotifier {
  int _selectindex = 0;

  final List<Widget> _item = [Dashboard(), Search(), Home(), Profile_info(), Message()];
  Widget Selectitem(int index) {return _item[index];}

  get Selectindex => _selectindex;
  List<Widget> get item => _item;

  SelectIndex_one() {_selectindex = 1; notifyListeners();}
  SelectIndex_two() {_selectindex = 2; notifyListeners();}
  SelectIndex_three() {_selectindex = 0; notifyListeners();}
  SelectIndex_four() {_selectindex = 3; notifyListeners();}
  SelectIndex_five() {_selectindex = 4; notifyListeners();}
}
