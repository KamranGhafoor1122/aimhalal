import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/custom_trace.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import '../../generated/l10n.dart';
import '../models/favorite.dart';
import '../models/food_model.dart';
import '../repository/product_repository.dart';

class ShowFoodsController extends ControllerMVC {
  List<Data> foods = <Data>[];
  List<Data> foodsAll = <Data>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  ShowFoodsController(String type) {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    if(type == "free"){
      fetchFreeFoods();
    }
    else{
      fetchPaidFoods();
    }
  }

  void fetchFreeFoods() async {
      Uri uri = Helper.getUri('api/get_sharefood');
      try {
        var response = await http.get(uri);
        if(response.statusCode == 200){
          FoodModel foodModel = FoodModel.fromJson(jsonDecode(response.body));
          foods = foodModel.data.where((element) =>element.type == null || element.type?.toLowerCase() =="free").toList();
          foodsAll = foods;
          setState(() { });
        }
      } catch (e) {
        print(CustomTrace(StackTrace.current, message: e.toString()).toString());
        return null;
      }

  }

  void fetchPaidFoods() async {
    Uri uri = Helper.getUri('api/get_sharefood');
    try {
      var response = await http.get(uri);
      if(response.statusCode == 200){
        FoodModel foodModel = FoodModel.fromJson(jsonDecode(response.body));
        foods = foodModel.data.where((element) =>element.type != null &&  element.type?.toLowerCase() != "free").toList();
        foodsAll = foods;
        setState(() { });
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()).toString());
      return null;
    }

  }


  searchFood(String text) {
     if(text.isEmpty){
       foods = foodsAll;
     }
     else{
       foods = foodsAll.where((element) => element.title.toLowerCase().contains(text.toLowerCase())).toList();
     }
     setState(() {});
  }

 refreshFreeFoods() async {
    foods.clear();
    fetchFreeFoods();
  }

  refreshPaidFoods() async {
    foods.clear();
    fetchPaidFoods();
  }
}
