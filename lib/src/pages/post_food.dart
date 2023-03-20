
import 'package:flutter/material.dart';
class PostFood extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
   PostFood({Key key,this.parentScaffoldKey}) : super(key: key);

  @override
  State<PostFood> createState() => _PostFoodState();
}

class _PostFoodState extends State<PostFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Post Food",
          style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(letterSpacing: 1.3)).copyWith(
              color: Theme.of(context).accentColor,
              fontSize: 12,
              fontWeight: FontWeight.w600
          ),
        ),

        actions: <Widget>[

          //new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12
            ),
            child: Column(
              children: [

                Row(
                  children: [
                    Expanded(child: Container(
                      height: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,color: Colors.black,),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Select Image",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,)),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),

                    Expanded(child: Container(
                      height: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,color: Colors.black,),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Select Image",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,)),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Container(
                      height: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,color: Colors.black,),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Select Image",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,)),
                        ],
                      ),
                    )),

                     SizedBox(
                       width: 10,
                     ),
                    Expanded(child: Container(
                      height: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,color: Colors.black,),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Select Image",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,)),
                        ],
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
