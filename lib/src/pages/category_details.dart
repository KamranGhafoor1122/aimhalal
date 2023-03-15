
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/models/setting.dart';

import '../../generated/l10n.dart';
import '../models/home_categories.dart';


ValueNotifier<Setting> setting = new ValueNotifier(new Setting());

class CategoryDetails extends StatefulWidget {
  List<Market> markets;
  CategoryDetails({Key key,this.markets}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).details,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10
          ),
          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
              itemCount: widget.markets.length,
              itemBuilder: (ctx,index){
              return Container(
                width: 200,
                margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Image of the card
                    Stack(
                      fit: StackFit.loose,
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: CachedNetworkImage(
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: widget.markets[index].media[0].url,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 130,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                              decoration: BoxDecoration(color: widget.markets[index].closed ? Colors.grey : Colors.green, borderRadius: BorderRadius.circular(24)),
                              child: widget.markets[index].closed
                                  ? Text(
                                S.of(context).closed,
                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                              )
                                  : Text(
                                S.of(context).open,
                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                              decoration: BoxDecoration(color: Helper.canDeliveryNew(widget.markets[index]) ? Colors.green : Colors.orange, borderRadius: BorderRadius.circular(24)),
                              child: Helper.canDeliveryNew(widget.markets[index])
                                  ? Text(
                                S.of(context).delivery,
                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                              )
                                  : Text(
                                S.of(context).pickup,
                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.markets[index].name,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  Helper.skipHtml(widget.markets[index].description),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: Helper.getStarsList(double.parse(widget.markets[index].rate)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                MaterialButton(
                                  elevation: 0,
                                  hoverElevation: 0,
                                  focusElevation: 0,
                                  highlightElevation: 0,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                   // Navigator.of(context).pushNamed('/Pages', arguments: new RouteArgument(id: '1', param: market));
                                  },
                                  child: Icon(Icons.directions_outlined, color: Theme.of(context).primaryColor),
                                  color: Theme.of(context).accentColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                widget.markets[index].distance > 0
                                    ? Text(
                                  Helper.getDistance(widget.markets[index].distance, Helper.of(context).trans(setting.value.distanceUnit)),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                )
                                    : SizedBox(height: 0)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
          }),
        ),
      ),
    );
  }
}
