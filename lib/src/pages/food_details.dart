

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../models/food_model.dart';
import '../models/media.dart';

class FoodDetails extends StatefulWidget {
  Data food;
  FoodDetails({Key key,this.food}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int current = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        *//*leading: new IconButton(
          icon:
          new Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),*//*
        title: Text(
          S.of(context).details,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),*/
      body: SafeArea(
        child: CustomScrollView(
          primary: true,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
              expandedHeight: 275,
              elevation: 0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 7),
                        height: 300,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                        },
                      ),
                      items: widget.food.images.map((String image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CachedNetworkImage(
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: image,
                              placeholder: (context, url) => Image.asset(
                                'assets/img/loading.gif',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 300,
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error_outline),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Container(
                      //margin: EdgeInsets.symmetric(vertical: 22, horizontal: 42),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.food.images.map((String image) {
                          return Container(
                            width: 20.0,
                            height: 5.0,
                            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: current == widget.food.images.indexOf(image)
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColor.withOpacity(0.4)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                          "Packing :",
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.food.packing??"",
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
                          "Serving for :",
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.food.servingFor??"",
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
                          "Valid till Date :",
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.food.validDate??"",
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
          ],
        ),
      ),

    );
  }
}
