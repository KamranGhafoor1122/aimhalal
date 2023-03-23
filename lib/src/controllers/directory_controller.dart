import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/custom_trace.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/models/directory_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import '../../generated/l10n.dart';
import '../models/favorite.dart';
import '../repository/product_repository.dart';

class DirectoryController extends ControllerMVC {
  List<Data> directories = <Data>[];
  List<Data> directoriesAll = <Data>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  DirectoryController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    fetchDirectories();
  }

  void fetchDirectories() async {
      Uri uri = Helper.getUri('api/get_directories');
      try {
        var response = await http.get(uri);
        if(response.statusCode == 200){
          DirectoryModel directoryModel = DirectoryModel.fromJson(jsonDecode(response.body));
          directories = directoryModel.data;
          directoriesAll = directoryModel.data;
          setState(() { });
        }
      } catch (e) {
        print(CustomTrace(StackTrace.current, message: e.toString()).toString());
        return null;
      }

  }

  searchDirectory(String text) {
    if(text.isEmpty){
      directories = directoriesAll;
    }
    else{
      directories = directoriesAll.where((element) => element.name.toLowerCase().contains(text.toLowerCase())).toList();
    }
    setState(() {});
  }
 refreshDirectories() async {
    directories.clear();
    fetchDirectories();
  }
}
