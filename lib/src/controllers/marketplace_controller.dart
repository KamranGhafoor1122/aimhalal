import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/custom_trace.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/models/marketplace_cateogy.dart' as MC;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import '../../generated/l10n.dart';
import '../models/favorite.dart';
import '../models/marketplace.dart';
import '../repository/product_repository.dart';

class MarketplaceController extends ControllerMVC {
  List<Data> marketPlaceItems = <Data>[];
  List<MC.Data> marketPlaceCategories = <MC.Data>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  MarketplaceController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  void fetchMarketplaceCategories() async {
    Uri uri = Helper.getUri('api/get_halal_market_place_categories');
    try {
      var response = await http.get(uri);
      if(response.statusCode == 200){
        MC.MarketplaceCategory eventModel = MC.MarketplaceCategory.fromJson(jsonDecode(response.body));
        marketPlaceCategories = eventModel.data;
        setState(() { });
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()).toString());
      return null;
    }

  }

  void fetchMarketplaceItems({@required int category_id}) async {
      Uri uri = Helper.getUri('api/get_halal_items?category=$category_id');
      try {
        var response = await http.get(uri);
        if(response.statusCode == 200){
          MarketPlace eventModel = MarketPlace.fromJson(jsonDecode(response.body));
          marketPlaceItems = eventModel.data;
          setState(() { });
        }
      } catch (e) {
        print(CustomTrace(StackTrace.current, message: e.toString()).toString());
        return null;
      }
  }

 refreshEvents() async {
    marketPlaceItems.clear();
    fetchMarketplaceItems();
  }
}
