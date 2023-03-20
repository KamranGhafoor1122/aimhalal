import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/custom_trace.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import '../../generated/l10n.dart';
import '../models/event_model.dart';
import '../models/favorite.dart';
import '../repository/product_repository.dart';

class EventsController extends ControllerMVC {
  List<Data> events = <Data>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  EventsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    fetchEvents();
  }

  void fetchEvents() async {
      Uri uri = Helper.getUri('api/get_events');
      try {
        var response = await http.get(uri);
        print("events cat res: ${response.statusCode} -- ${response.body}");
        if(response.statusCode == 200){
          EventModel eventModel = EventModel.fromJson(jsonDecode(response.body));
          events = eventModel.data;
          setState(() { });
        }
      } catch (e) {
        print(CustomTrace(StackTrace.current, message: e.toString()).toString());
        return null;
      }

  }
 refreshEvents() async {
    events.clear();
    fetchEvents();
  }
}
