import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:markets/src/elements/SearchBarWidget.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../models/slide.dart';
import 'HomeSliderLoaderWidget.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<Slide> slides;
  final String name;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides,this.parentScaffoldKey,this.name}) : super(key: key);
}


class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  var _today = HijriCalendar.now();
  var date = DateTime.now();
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    return widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Column(
          /*  alignment: _alignmentDirectional ?? Helper.getAlignmentDirectional(widget.slides.elementAt(0).textPosition),
            fit: StackFit.passthrough,
            clipBehavior: Clip.none,*/
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Expanded(
                       child: Text("${widget.name??""}",
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       style: Theme.of(context).textTheme.headline1.copyWith(
                         fontSize: 14,
                           fontWeight: FontWeight.w500,
                           color: Theme.of(context).accentColor
                       ),
                       ),
                     ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            
                            Text("${_today.toFormat("dd MMMM,yyyy")} | ",
                              style: Theme.of(context).textTheme.headline1.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).accentColor
                              ),
                            ),
                            Text("${DateFormat("dd MMM,yyyy").format(date)}",
                              style: Theme.of(context).textTheme.headline1.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).accentColor
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 180,
                width: double.infinity,
                child: Stack(

                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        height: 180,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                            _alignmentDirectional = Helper.getAlignmentDirectional(widget.slides.elementAt(index).textPosition);
                          });
                        },
                      ),
                      items: widget.slides.map((Slide slide) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.symmetric( horizontal: 16),
                              height: 1800,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), blurRadius: 15, offset: Offset(0, 2)),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      height: 180,
                                      width: double.infinity,
                                      fit: Helper.getBoxFit(slide.imageFit),
                                      imageUrl: slide.image.url,
                                      placeholder: (context, url) => Image.asset(
                                        'assets/img/loading.gif',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 180,
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                    ),
                                  ),

                                  Container(
                                    alignment: Helper.getAlignmentDirectional(slide.textPosition),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Container(
                                      width: config.App(context).appWidth(40),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          if (slide.text != null && slide.text != '')
                                            Text(
                                              slide.text,
                                              style: Theme.of(context).textTheme.headline6.merge(
                                                    TextStyle(
                                                      fontSize: 14,
                                                      height: 1,
                                                      color: Helper.of(context).getColorFromHex(slide.textColor),
                                                    ),
                                                  ),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                              maxLines: 3,
                                            ),
                                          if (slide.button != null && slide.button != '')
                                            MaterialButton(
                                              elevation: 0,
                                              onPressed: () {
                                                if (slide.market.id != 'null') {
                                                  Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: slide.market.id, heroTag: 'home_slide'));
                                                } else if (slide.product.id != 'null') {
                                                  Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: slide.product.id, heroTag: 'home_slide'));
                                                }
                                              },
                                              padding: EdgeInsets.symmetric(vertical: 5),
                                              color: Helper.of(context).getColorFromHex(slide.buttonColor),
                                              shape: StadiumBorder(),
                                              child: Text(
                                                slide.button,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(color: Theme.of(context).primaryColor),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),

                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 42),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.slides.map((Slide slide) {
                          return Container(
                            width: 20.0,
                            height: 3.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: _current == widget.slides.indexOf(slide)
                                    ? Helper.of(context).getColorFromHex(slide.indicatorColor)
                                    : Helper.of(context).getColorFromHex(slide.indicatorColor).withOpacity(0.3)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: HomeSearchBarWidget(
                    onClickFilter: (event) {
                      widget.parentScaffoldKey.currentState.openEndDrawer();
                    },
                  ),
                ),
              ),

              /*Positioned(
                bottom: -40,
                left: 15,
                right: 15,
                child:
              )*/

            ],
          );
  }
}
