import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/event_model.dart';

class EventsDetails extends StatefulWidget {
  Data event;
  EventsDetails({Key key,this.event}) : super(key: key);

  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "${widget.event.name}",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.event.image,
                      fit: BoxFit.fill,
                      placeholder:(ctx,_)=> Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(Icons.image,size: 80,),
                      ),
                      errorWidget:(ctx,_,dynamic)=> Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(Icons.image,size: 80,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Center(
                    child: Text(
                      widget.event.name,
                      style: Theme.of(context).textTheme.bodyLarge.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Location: ${widget.event.location}",
                    style: Theme.of(context).textTheme.bodyLarge.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Date: ${widget.event.date}",
                    style: Theme.of(context).textTheme.bodyLarge.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
