import 'package:flutter/material.dart';
import 'package:markets/src/pages/food_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/directory_controller.dart';
import '../controllers/events_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/show_foods_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/EventGridItemWidget.dart';
import '../elements/FavoriteGridItemWidget.dart';
import '../elements/FavoriteListItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/food_model.dart';
import '../repository/user_repository.dart';

class HomeChefs extends StatefulWidget {
  String name;

  HomeChefs(this.name);

  @override
  _HomeChefsState createState() => _HomeChefsState();
}

class _HomeChefsState extends StateMVC<HomeChefs> {
  String layout = 'grid';

  ShowFoodsController _con;

  _HomeChefsState() : super(ShowFoodsController("free")) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
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
          widget.name,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _con.refreshFreeFoods();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  onSubmitted: (text) async {
                  },
                  onChanged: (query){
                      _con.searchFood(query);
                  },
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                    hintText: "Search",
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),
              ),
              SizedBox(height: 10),

              _con.foods.isEmpty
                  ? CircularLoadingWidget(height: 500)
                  : Offstage(
                  offstage: this.layout != 'grid',
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      crossAxisSpacing: 7,
                        childAspectRatio: 0.86
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7
                      ),
                      itemCount: _con.foods.length,
                      itemBuilder: (ctx,index) {
                        Data food = _con.foods[index];
                        return  GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>FoodDetails(food: food,)));
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Hero(
                                      tag:DateTime.now().millisecondsSinceEpoch.toString(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage("assets/img/image_ph.jpg"), fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    food.title,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                     food.type??"free",
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              /*Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: MaterialButton(
              elevation: 0,
              padding: EdgeInsets.all(0),
              onPressed: () {
                widget.onPressed();
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              color: Theme.of(context).accentColor.withOpacity(0.9),
              shape: StadiumBorder(),
            ),
          ),*/
                            ],
                          ),
                        );
                          /*Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Theme
                                .of(context)
                                .focusColor
                                .withOpacity(0.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Title :", style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6,),
                                  SizedBox(width: 10,),
                                  Text(
                                    _con.foods[index].title ?? "",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),

                                ],
                              ),

                              SizedBox(
                                height: 6,
                              ),

                              Row(
                                children: [
                                  Text("Type :", style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6,),
                                  SizedBox(width: 10,),
                                  Text(
                                    _con.foods[index].type ?? "",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),

                                ],
                              ),

                              SizedBox(
                                height: 6,
                              ),

                              Row(
                                children: [
                                  Text("Price :", style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6,),
                                  SizedBox(width: 10,),
                                  Text(
                                    _con.foods[index].price == 0 ? "Free" : _con.foods[index].price.toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),

                                ],
                              ),


                              SizedBox(
                                height: 6,
                              ),

                              Row(
                                children: [
                                  Text("Contact Number :", style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6,),
                                  SizedBox(width: 10,),
                                  Text( _con.foods[index].contactNumber.toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),

                                ],
                              ),


                              SizedBox(
                                height: 6,
                              ),

                              Row(
                                children: [
                                  Text("Location :", style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6,),
                                  SizedBox(width: 10,),
                                  Text(
                                    _con.foods[index].location.toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),

                                ],
                              ),


                              SizedBox(
                                height: 6,
                              ),

                              Row(
                                children: [
                                  Text("Details :", style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6,),
                                  SizedBox(width: 10,),
                                  Text(
                                    _con.foods[index].details,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        );*/
                      }
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
