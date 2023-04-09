import 'package:flutter/material.dart';
import 'package:markets/src/models/home_categories.dart';
import 'package:markets/src/pages/evevnts.dart';

import '../../generated/l10n.dart';
import '../elements/CardsCarouselLoaderWidget.dart';
import '../models/market.dart' as M;
import '../models/route_argument.dart';
import '../pages/category_details.dart';
import '../pages/directories.dart';
import '../pages/food_share.dart';
import '../pages/my_webview.dart';
import '../pages/home_chefs.dart';
import 'CardWidget.dart';

// ignore: must_be_immutable
class CardsCarouselWidget extends StatefulWidget {
  List<M.Market> marketsList;
  List<Datum> homeCategories;
  bool hideCategories;
  String heroTag;

  CardsCarouselWidget({Key key, this.marketsList, this.heroTag,this.homeCategories,this.hideCategories=false}) : super(key: key);

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
              mainAxisSize: MainAxisSize.min,
              children: [


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Featured",
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
                      return
                        GestureDetector(
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
                SizedBox(
                  height: 5,
                ),


                widget.hideCategories ? Container():  widget.homeCategories == null ? Center(
                  child: CircularProgressIndicator(),
                ):
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                      childAspectRatio: 0.72
                  ),
                      itemCount: widget.homeCategories.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx,index){
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: (){
                            print("cat: ${widget.homeCategories[index].id}");
                            if(widget.homeCategories[index].name == "Quran Learning"){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MyWebview(title: "Quran Learning", url: widget.homeCategories[index].url)));
                            }
                            else if(widget.homeCategories[index].name.contains("Events")){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>EventsWidget()));
                            }
                            else if(widget.homeCategories[index].id == 11){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DirectoryWidget(widget.homeCategories[index].name)));
                            }
                            else if(widget.homeCategories[index].id == 16){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomeChefs(widget.homeCategories[index].name)));
                            }
                            else if(widget.homeCategories[index].id == 17){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>FoodShare(widget.homeCategories[index].name)));
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CategoryDetails(markets: widget.homeCategories[index].markets,
                                name: widget.homeCategories[index].name,
                              )));
                            }
                          },
                          child: Container(
                            /*decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(7.0)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue,
                                  Colors.deepPurple
                                ],
                              ),
                            )*/
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),

                                SizedBox(
                                  height: 75,
                                  width: 98,
                                  child: Image.network(widget.homeCategories[index].image,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    widget.homeCategories[index].name.replaceFirst(" ", "\n"),
                                    textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodySmall.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white: Colors.black
                                    )
                                ),



                              ],
                            ),
                          ),
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



              ],
            ),
          );
  }
}
