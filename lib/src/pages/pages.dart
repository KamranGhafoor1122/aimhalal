import 'package:flutter/material.dart';
import 'package:markets/src/elements/SearchWidget.dart';

import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/notifications.dart';
import '../pages/orders.dart';
import 'package:flutter_svg/svg.dart';
import '../repository/settings_repository.dart';
import 'messages.dart';
import 'post_food.dart';
import 'profile.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {

      if(tabItem != 3){
        widget.currentTab = tabItem;
      }
      switch (tabItem) {
       /* case 0:
          widget.currentPage = NotificationsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = MapWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: widget.routeArgument);
          break;*/
        case 0:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = MapWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: widget.routeArgument);
          break;

        case 2:
          widget.currentPage = PostFood(parentScaffoldKey: widget.scaffoldKey);
          break;

        case 3:
          Navigator.of(navigatorKey.currentContext).push(SearchModal());
          break;

        case 4:
          widget.currentPage = ProfileWidget(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;

       /* case 3:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentPage = MessagesWidget(parentScaffoldKey: widget.scaffoldKey); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        endDrawer: FilterWidget(onFilter: (filter) {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: widget.currentTab);
        }),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 27,
          elevation: 0,
          showSelectedLabels: true,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: new Icon( Icons.home , color: widget.currentTab == 0? Theme.of(context).accentColor:Colors.grey),
        ),

              /*BottomNavigationBarItem(
              icon: Icon(widget.currentTab == 0 ? Icons.notifications : Icons.notifications_outlined),
              label: '',
            ),*/
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/img/discover.svg", color: widget.currentTab == 1? Theme.of(context).accentColor:Colors.grey,),
              label: 'Discover',
            ),


            BottomNavigationBarItem(
              label:"",
              icon: Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                  BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                ],
              ),
              child: new Icon(widget.currentTab == 2 ? Icons.add : Icons.add, color: Theme.of(context).primaryColor),
            ), ),



            BottomNavigationBarItem(
              icon: new Icon(  Icons.search,color: widget.currentTab == 3 ? Theme.of(context).accentColor:Colors.grey,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/img/profile.svg", color: widget.currentTab == 4? Theme.of(context).accentColor:Colors.grey,),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
