

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../models/food_model.dart';

class FoodDetails extends StatefulWidget {
  Data food;
  FoodDetails({Key key,this.food}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: new IconButton(
          icon:
          new Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
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
            horizontal: 15,
            vertical: 12
          ),
          child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Title :",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.food.title,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      "Type :",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.food.type??"",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      "Price :",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.food.price?.toString()??"0",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      "Details :",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.food.details,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),


                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      "Location :",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.food.location,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      "Number :",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.food.contactNumber,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    MaterialButton(
                      elevation: 0,
                      onPressed: () {
                        launch("tel:${widget.food.contactNumber}");
                      },
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: StadiumBorder(),
                      color: Theme.of(context).accentColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.call, color: Theme.of(context).primaryColor),
                          Text(
                            "Call",
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              ],
          ),
        ),
      ),

    );
  }
}
