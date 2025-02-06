import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:biometric/src/ui/pages/home/home_vm.dart';
import 'package:provider/provider.dart';

class ApiCall {
  static Future<void> fetchData(
      {int page = 1, int perPage = 15, required BuildContext context}) async {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    
    final Uri url = Uri.parse('https://api.github.com/users/subshegde/repos?page=$page&per_page=$perPage');

    String githubToken = '';

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $githubToken',
      },
    );

    if (response.statusCode == 200) {
      for (int index = 0; index < perPage; index++) {
        viewModel.githubUserName =
            jsonDecode(response.body)[index]['name'] ?? 'null';
        viewModel.githubDesc =
            jsonDecode(response.body)[index]['description'] ?? 'null';
        viewModel.githubLang =
            jsonDecode(response.body)[index]['language'] ?? 'null';
        viewModel.githubFork =
            jsonDecode(response.body)[index]['forks'].toString();
        viewModel.githubBug =
            jsonDecode(response.body)[index]['open_issues'].toString();
      }
    } else {
      log(response.body);
    }
  }
}
