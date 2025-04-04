
// ignore_for_file: prefer_final_fields, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../API_Controller/Candidate/Collction/Location/preferencetype_API_controller.dart';
import '../../../API_Controller/Candidate/Collction/Pop_Collection/CountryList_pop_controller.dart';

class UserSearchController with ChangeNotifier {
  final CountrylistPopController country = Get.put(CountrylistPopController());
  final PreferencetypeApiController Preferencetype = Get.put(PreferencetypeApiController());

  String _select = "";
  bool _hasInitialized = false;

  // Debounce Timer
  Timer? _debounce;

  void onInit(BuildContext context) {
    if (!_hasInitialized) {
      _hasInitialized = true;
      _bottamApiCall(context);
    }
  }

  Future<void> _bottamApiCall(BuildContext context) async {
    await Future.microtask(() {
      country.CountrylistPopController_fuction();
    });
  }

  get select => _select;

  ValueNotifier<bool> _selectboll = ValueNotifier<bool>(false);
  ValueNotifier<bool> _selectmain = ValueNotifier<bool>(false);

  get selectboll => _selectboll;
  get selectmain => _selectmain;

  void selectboll_fun() {
    _selectboll.value = true;
    notifyListeners();
  }

  void select_main() {
    _selectmain.value = true;
    notifyListeners();
  }

  bool _Savebutton = true;

  get Savebutton => _Savebutton;

  var _selectedCountryId;
  var _selectedStateId;
  String _selectedState = '';
  List _states = [];
  List _City = [];
  List _filteredStates = []; // New property for filtered states

  get selectedCountryId => _selectedCountryId;
  get selectedStateId => _selectedStateId;
  String get selectedState => _selectedState;
  get states => _states;
  get City => _City;
  List get filteredStates => _filteredStates; // Getter for filtered states

  void updateCountrySelection({required String countryId, required List provinceList,}) {
    _selectedCountryId = countryId;
    _states = provinceList;
    _filteredStates = provinceList;
    _selectedState = '';
    notifyListeners();
  }

  void updateStateSelection(String stateName) {
    _selectedState = stateName;
    _City = _states.firstWhere((state) => state['Name'] == stateName)['CityList'] ?? [];
    _select = stateName;
    _Savebutton = true;
    _selectboll.value = true;
    _selectmain.value = true;
    notifyListeners();
  }

  void filterStates(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        _filteredStates = _states;
      } else {
        _filteredStates = _states.where((state) => state['Name'].toLowerCase().contains(query.toLowerCase())).toList();
      }
      if (_filteredStates.isEmpty) {
        _filteredStates = [];
      }
      notifyListeners();
    });
  }
}
