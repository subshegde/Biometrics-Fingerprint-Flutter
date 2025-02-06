import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:biometric/src/core/constants/style.dart';
import 'package:biometric/src/core/utils/snackBar.dart';
import 'package:biometric/src/ui/pages/home/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    _isConnectedOrNot();
    recordLocalDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Github Repositories',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: Colors.white),
        ),
      ),
      body: _provider.isLoading
          ? ListView.builder(
              controller: _provider.scrollController,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _provider.githubUserName.length + 1,
              itemBuilder: (ctx, idx) {
                //checking
                if (idx < _provider.githubUserName.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.asset('assets/icons/folder.png',scale: 10,),
                          title: Text(
                            _provider.githubUserName[idx],
                            style: kTextStyle,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _provider.githubDesc[idx],
                                style: kTextStyle2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '< > ${_provider.githubLang[idx]}',
                                    style: kTextStyle2,
                                  ),
                                  Text(
                                    '𓆣 ${_provider.githubBug[idx]}',
                                    style: kTextStyle2,
                                  ),
                                  Text(
                                    '👦 ${_provider.githubFork[idx]}',
                                    style: kTextStyle2,
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  _provider.initState(context);
                  _provider.recordLocalData();
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  _isConnectedOrNot() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      log('Your Connected To Internet');
    } else {
      showSnackBar(
          message: 'Connect internet to get updated records', context: context);
      log('No internet :( Reason:');
    }
  }

  // getting recodedData
  recordLocalDataFromDB() async {
    final _hmp = Provider.of<HomeViewModel>(context, listen: false);

    final _pref = await SharedPreferences.getInstance();
    if (_pref.getStringList('Name') != null) {
      for (var item in _pref.getStringList('Name')!) {
        _hmp.githubUserName = item;
      }
      for (var item in _pref.getStringList('Description')!) {
        _hmp.githubDesc = item;
      }
      for (var item in _pref.getStringList('Language')!) {
        _hmp.githubLang = item;
      }
      for (var item in _pref.getStringList('Bug')!) {
        _hmp.githubBug = item;
      }
      for (var item in _pref.getStringList('Fork')!) {
        _hmp.githubFork = item;
      }
      _hmp.isLoading = true;
    }
  }
}
