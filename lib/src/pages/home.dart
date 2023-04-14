import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Loc;
import 'package:markets/src/pages/category_details.dart';
import 'package:markets/src/pages/directories.dart';
import 'package:markets/src/pages/evevnts.dart';
import 'package:markets/src/pages/food_share.dart';
import 'package:markets/src/pages/home_chefs.dart';
import 'package:markets/src/pages/my_webview.dart';
import 'package:markets/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/CaregoriesCarouselWidget.dart';
import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/maps_util.dart';
import '../models/address.dart';
import '../models/setting.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';
import 'notifications.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;
  String address;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    showCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Image.asset("assets/img/AimHalal.png",
            fit: BoxFit.cover,
              height: 75,
            ),
            SizedBox(width: 7,),

           /* Text(
              "AimHalal",
              style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.3)).copyWith(
                color: Theme.of(context).accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),*/

          ],
        ),

       /* ValueListenableBuilder(
          valueListenable: settingsRepo.deliveryAddress,
          builder: (context, Address value, child) {
            return Row(
              children: [
                Expanded(
                  child: ,
                ),
              ],
            );
          },
        ),*/
        actions: <Widget>[

          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>NotificationsWidget(parentScaffoldKey: widget.parentScaffoldKey,)));
          },
              icon: Icon(Icons.notifications,color: Colors.grey,))
          //new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshHome,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(settingsRepo.setting.value.homeSections.length, (index) {
              String _homeSection = settingsRepo.setting.value.homeSections.elementAt(index);
              switch (_homeSection) {
                case 'slider':
                  return HomeSliderWidget(slides: _con.slides,parentScaffoldKey: widget.parentScaffoldKey,
                  categories: _con.homeCategories1,
                  name: address,
                  );
                case 'search':
                  return Container();
                case 'top_markets':
                  return CardsCarouselWidget(marketsList: _con.topMarkets, heroTag: 'home_top_markets',homeCategories: _con.homeCategories2,);
                case 'top_markets_heading':
                  return Padding(
                    padding: const EdgeInsets.only(top: 1, left: 20, right: 5, bottom: 5),
                    child: Container()
                  );


                   /* Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                S.of(context).top_markets,
                                style: Theme.of(context).textTheme.headline4,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (currentUser.value.apiToken == null) {
                                  _con.requestForCurrentLocation(context);
                                } else {
                                  var bottomSheetController = widget.parentScaffoldKey.currentState.showBottomSheet(
                                        (context) => DeliveryAddressBottomSheetWidget(scaffoldKey: widget.parentScaffoldKey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                    ),
                                  );
                                  bottomSheetController.closed.then((value) {
                                    _con.refreshHome();
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: settingsRepo.deliveryAddress.value?.address == null
                                      ? Theme.of(context).focusColor.withOpacity(0.1)
                                      : Theme.of(context).accentColor,
                                ),
                                child: Text(
                                  S.of(context).delivery,
                                  style: TextStyle(
                                      color:
                                      settingsRepo.deliveryAddress.value?.address == null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                            SizedBox(width: 7),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  settingsRepo.deliveryAddress.value?.address = null;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: settingsRepo.deliveryAddress.value?.address != null
                                      ? Theme.of(context).focusColor.withOpacity(0.1)
                                      : Theme.of(context).accentColor,
                                ),
                                child: Text(
                                  S.of(context).pickup,
                                  style: TextStyle(
                                      color:
                                      settingsRepo.deliveryAddress.value?.address != null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        *//*if (settingsRepo.deliveryAddress.value?.address != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              S.of(context).near_to + " " + (settingsRepo.deliveryAddress.value?.address),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),*//*
                      ],
                    ),
                  );*/
                case 'trending_week_heading':
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    leading: Icon(
                      Icons.trending_up,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).trending_this_week,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: Text(
                      S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                case 'trending_week':
                  return ProductsCarouselWidget(productsList: _con.trendingProducts, heroTag: 'home_product_carousel');
                case 'categories_heading':
                  return
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.category_outlined,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        S.of(context).product_categories,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  );
                case 'categories':
                  return CategoriesCarouselWidget(
                    categories: _con.categories,
                  );
                case 'popular_heading':
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.trending_up,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        S.of(context).most_popular,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  );
                case 'popular':
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridWidget(
                      marketsList: _con.popularMarkets,
                      heroTag: 'home_markets',
                    ),
                  );
                case 'recent_reviews_heading':
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      leading: Icon(
                        Icons.recent_actors_outlined,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        S.of(context).recent_reviews,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  );
                case 'recent_reviews':
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ReviewsListWidget(reviewsList: _con.recentReviews),
                  );
                default:
                  return SizedBox(height: 0);
              }
            }),
          ),
        ),
      ),
    );
  }
  Future<dynamic> showCurrentLocation() async {
    Loc.Location location =  Loc.Location();
    MapsUtil mapsUtil = new MapsUtil();
    final whenDone = new Completer();
    Address _address = new Address();
    location.requestService().then((value) async {
      location.getLocation().then((_locationData) async {
          List<Placemark> newPlace = await placemarkFromCoordinates(_locationData?.latitude, _locationData?.longitude);

          // this is all you need
          Placemark placeMark  = newPlace[0];
          String name = placeMark.name;
          String subLocality = placeMark.subLocality;
          String locality = placeMark.locality;
          String administrativeArea = placeMark.administrativeArea;
          String postalCode = placeMark.postalCode;
          String country = placeMark.country;
           address = "${subLocality}, ${locality}, $country";

          print("address $address");
          setState(() { });

        whenDone.complete(_address);
      }).timeout(Duration(seconds: 10), onTimeout: () async {
        whenDone.complete(_address);
        return null;
      }).catchError((e) {
        whenDone.complete(_address);
      });
    });
    return whenDone.future;
  }
}
