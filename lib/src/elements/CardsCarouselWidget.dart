import 'package:flutter/material.dart';
import 'package:markets/src/models/home_categories.dart';

import '../../generated/l10n.dart';
import '../elements/CardsCarouselLoaderWidget.dart';
import '../models/market.dart' as M;
import '../models/route_argument.dart';
import 'CardWidget.dart';

// ignore: must_be_immutable
class CardsCarouselWidget extends StatefulWidget {
  List<M.Market> marketsList;
  HomeCategories homeCategories;
  String heroTag;

  CardsCarouselWidget({Key key, this.marketsList, this.heroTag,this.homeCategories}) : super(key: key);

  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.marketsList.isEmpty
        ? CardsCarouselLoaderWidget()
        : Container(
            //height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.homeCategories == null ? Center(
                  child: CircularProgressIndicator(),
                ):
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
                  crossAxisSpacing: 8,
                    mainAxisSpacing: 7,
                    childAspectRatio: 0.88
                  ),
                      itemCount: widget.homeCategories.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx,index){
                         return Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             SizedBox(
                               height: 5,
                             ),

                             SizedBox(
                               height: 43,
                               width: 43,
                               child: Image.network(widget.homeCategories.data[index].image,
                               ),
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               widget.homeCategories.data[index].name,
                               maxLines: 1,
                             //  overflow: TextOverflow.ellipsis,
                               style: Theme.of(context).textTheme.bodySmall.copyWith(
                                   color: Colors.black,
                                   fontSize: 8
                               ),
                             ),



                           ],
                         );

                           /*Container(
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: Theme.of(context).accentColor,
                           ),
                           padding: EdgeInsets.all(20),
                           child:
                         );*/
                      }),
                ),


                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    S.of(context).top_markets,
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.marketsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/Details',
                              arguments: RouteArgument(
                                id: '0',
                                param: widget.marketsList.elementAt(index).id,
                                heroTag: widget.heroTag,
                              ));
                        },
                        child: CardWidget(market: widget.marketsList.elementAt(index), heroTag: widget.heroTag),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
