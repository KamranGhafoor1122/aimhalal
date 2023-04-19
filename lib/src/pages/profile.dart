import 'package:flutter/material.dart';
import 'package:markets/src/elements/CircularLoadingWidget.dart';
import 'package:markets/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/profile_controller.dart';
import '../elements/DrawerWidget.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/ProfileAvatarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/food_model.dart';
import 'food_details.dart';
import 'home_chefs.dart';



//ValueNotifier<userModel.User> currentUser = new ValueNotifier(userModel.User());

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProfileWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends StateMVC<ProfileWidget> {
  ProfileController _con;

  _ProfileWidgetState() : super(ProfileController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    print("current user : ${currentUser.value.toMap()}");
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).primaryColor),
          onPressed: () => _con.scaffoldKey?.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).profile,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
        ),
        actions: <Widget>[
         // new ShoppingCartButtonWidget(iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).hintColor),
        ],
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : SingleChildScrollView(
//              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                children: <Widget>[
                  ProfileAvatarWidget(user: currentUser.value,con: _con,),
                  /*ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    leading: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).about,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      currentUser.value?.bio ?? "",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),*/
                 /* ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Icon(
                      Icons.shopping_basket_outlined,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).recent_orders,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),*/
                 /* ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    leading: Icon(
                      Icons.delete_outlined,
                      color: Theme.of(context).hintColor,
                    ),
                    onTap: () async{




                    },
                    title: Text(
                      "Delete Account",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),*/

                 /* ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Icon(
                      Icons.emoji_food_beverage_sharp,
                      color: Theme.of(context).hintColor,
                    ),
                    onTap: () async{
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ShowFoods()));


                    },
                    title: Text(
                      "Foods",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),*/
                 /* _con.recentOrders.isEmpty
                      ? EmptyOrdersWidget()
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.recentOrders.length,
                          itemBuilder: (context, index) {
                            var _order = _con.recentOrders.elementAt(index);
                            return OrderItemWidget(expanded: index == 0 ? true : false, order: _order);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                        ),*/

                  _con.foods == null
                      ? CircularLoadingWidget(height: 500)
                      :
                  _con.foods.isNotEmpty?
                  GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
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
                            return FoodItem(food: food,);
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
                      ):SizedBox(
                    height: 500,
                    child: Center(
                      child: Text("No data found",style: Theme.of(context).textTheme.bodyMedium,),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class FoodItem extends StatelessWidget {
  Data food;
   FoodItem({this.food,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                food.price == 0 ?"Free" : food.price.toString(),
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
  }
}
