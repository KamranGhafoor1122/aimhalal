import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/pages/events_details.dart';

import '../models/event_model.dart';
import '../models/favorite.dart';
import '../models/route_argument.dart';

class EventGridItemWidget extends StatelessWidget {
  final String heroTag;
  final Data event;

  EventGridItemWidget({Key key, this.heroTag, this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EventsDetails(event: event,)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: heroTag + "${event.id}",
            child: Container(
              height: 160,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                   imageUrl: event.image,
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
            ),
            ),
          SizedBox(height: 5),
          Text(
            event.name,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2),
          Text(
            event.location,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
