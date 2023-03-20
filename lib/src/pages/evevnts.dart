import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/events_controller.dart';
import '../controllers/favorite_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/EventGridItemWidget.dart';
import '../elements/FavoriteGridItemWidget.dart';
import '../elements/FavoriteListItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';

class EventsWidget extends StatefulWidget {
  @override
  _EventsWidgetState createState() => _EventsWidgetState();
}

class _EventsWidgetState extends StateMVC<EventsWidget> {
  String layout = 'grid';

  EventsController _con;

  _EventsWidgetState() : super(EventsController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: true,

        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Events",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
        //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
              onRefresh: () async{
                _con.refreshEvents();
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: SearchBarWidget(onClickFilter: (e) {
                    //     Scaffold.of(context).openEndDrawer();
                    //   }),
                    // ),
                    SizedBox(height: 10),

                    _con.events.isEmpty
                        ? CircularLoadingWidget(height: 500)
                        : Offstage(
                            offstage: this.layout != 'grid',
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10
                              ),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                              childAspectRatio: 0.85,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10
                              ),
                              itemCount: _con.events.length,
                              itemBuilder: (ctx,index)=> EventGridItemWidget(
                                  heroTag: 'events_grid',
                                  event: _con.events[index],
                              // Generate 100 widgets that display their index in the List.),
                            ),
                          ))
                  ],
                ),
              ),
            ),
    );
  }
}
