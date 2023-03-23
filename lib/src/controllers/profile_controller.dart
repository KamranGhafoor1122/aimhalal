import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/custom_trace.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import '../../generated/l10n.dart';
import '../models/food_model.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';

class ProfileController extends ControllerMVC {
  List<Order> recentOrders = [];
  List<Data> foods = <Data>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForRecentOrders();
    fetchShowFoods();
  }

  void listenForRecentOrders({String message}) async {
    final Stream<Order> stream = await getRecentOrders();
    stream.listen((Order _order) {
      setState(() {
        recentOrders.add(_order);
      });
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void fetchShowFoods() async {
    Uri uri = Helper.getUri('api/get_sharefood');
    try {
      var response = await http.get(uri);
      if(response.statusCode == 200){
        FoodModel foodModel = FoodModel.fromJson(jsonDecode(response.body));
        foods = foodModel.data;
        setState(() { });
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()).toString());
      return null;
    }
  }


  Future<http.Response> deleteAccount(String userId) async {
    Uri uri = Helper.getUri('api/delete_user');
    try {
       Map<String,dynamic> body = {
         "user_id":userId
       };
      var response = await http.post(uri,body: body);
      print("home cat res: ${response.statusCode} -- ${response.body}");
      return response;
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()).toString());
      return null;
    }
  }
}
