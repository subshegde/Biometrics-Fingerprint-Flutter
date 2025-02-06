import 'package:flutter/cupertino.dart';
import 'package:biometric/src/core/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  // var declare
  ScrollController _scrollController = ScrollController();
  List<String> _githubUserName = [];
  List<String> _githubDesc = [];
  List<String> _githubLang = [];
  List<String> _githubFork = [];
  List<String> _githubBug = [];
  final int _page = 1;
  int _perPage = 1;
  bool _isLoading = false;

  // getters
  ScrollController get scrollController => _scrollController;
  bool get isLoading => _isLoading;
  List<String> get githubUserName => _githubUserName;
  List<String> get githubDesc => _githubDesc;
  List<String> get githubLang => _githubLang;
  List<String> get githubFork => _githubFork;
  List<String> get githubBug => _githubBug;
  // setters
  set scrollController(value) {
    _scrollController = value;
    notifyListeners();
  }

  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  set perPage(int value) {
    _perPage += value;
    notifyListeners();
  }

  set githubUserName(value) {
    _githubUserName.add(value);
    notifyListeners();
  }

  set githubDesc(value) {
    _githubDesc.add(value);
    notifyListeners();
  }

  set githubLang(value) {
    _githubLang.add(value);
    notifyListeners();
  }

  set githubFork(value) {
    _githubFork.add(value);
    notifyListeners();
  }

  set githubBug(value) {
    _githubBug.add(value);
    notifyListeners();
  }

  // functions
  void initState(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        // call api
        perPage = 1;
        _fetchData(context);
      }
    });
  }

  checkCall(BuildContext context) {
    perPage = 14;
    _fetchData(context);
  }

  _fetchData(BuildContext context) async {
    await ApiCall.fetchData(page: _page, perPage: _perPage, context: context);
    _isLoading = true;
    notifyListeners();
  }

  recordLocalData() async {
    final _pref = await SharedPreferences.getInstance();
    if (_githubUserName.isNotEmpty) {
      await _pref.setStringList('Name', _githubUserName);
      await _pref.setStringList('Description', _githubDesc);
      await _pref.setStringList('Language', _githubLang);
      await _pref.setStringList('Bug', _githubBug);
      await _pref.setStringList('Fork', _githubFork);
    }
    notifyListeners();
  }
}
