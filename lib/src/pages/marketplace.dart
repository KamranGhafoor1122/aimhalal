import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/marketplace_controller.dart';
import '../elements/CircularLoadingWidget.dart';

class MarketPlace extends StatefulWidget {
  String name;

  MarketPlace(this.name);

  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends StateMVC<MarketPlace> {
  String layout = 'grid';

  MarketplaceController _con;

  _MarketPlaceState() : super(MarketplaceController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await _con.fetchMarketplaceCategories();
     _con.fetchMarketplaceItems(category_id: _con.marketPlaceCategories?.first?.id??"3");
    });
    super.initState();
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
          "${widget.name}",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
        //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
              onRefresh: () async{
                _con.refreshEvents();
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: SearchBarWidget(onClickFilter: (e) {
                    //     Scaffold.of(context).openEndDrawer();
                    //   }),
                    // ),
                    SizedBox(height: 10),

                    _con.marketPlaceCategories.isEmpty?CircularProgressIndicator():
                        SizedBox(
                          height: 200,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx,index)=> Column(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                  imageUrl: _con.marketPlaceCategories[index].image??"",
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
                                height: 10,
                              ),
                              Text(
                                _con.marketPlaceCategories[index].name,
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                          separatorBuilder:(ctx,index)=> SizedBox(
                            width: 10,
                          ),
                            itemCount: _con.marketPlaceCategories.length,
                          ),
                        ),
                    _con.marketPlaceItems.isEmpty
                        ? CircularLoadingWidget(height: 500)
                        : Expanded(
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10
                              ),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                              childAspectRatio: 0.85,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10
                              ),
                              itemCount: _con.marketPlaceItems.length,
                              itemBuilder: (ctx,index)=> InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Theme.of(context).accentColor.withOpacity(0.08),
                                onTap: () {
                                 // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EventsDetails(event: event,)));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 160,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: _con.marketPlaceItems[index].images.first??"",
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
                                    SizedBox(height: 5),
                                    Text(
                                      _con.marketPlaceItems[index].name,
                                      style: Theme.of(context).textTheme.bodyText1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      _con.marketPlaceItems[index].price,
                                      style: Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                          ))
                  ],
                ),
              ),
            ),
    );
  }
}
