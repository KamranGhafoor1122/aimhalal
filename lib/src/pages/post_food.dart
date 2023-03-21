
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               /* Row(
                  children: [
                    Expanded(child: Container(
                      height: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),
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
                              color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),
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
                              color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),
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
                              color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),
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
                )*/

                Text("Title", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600
                ),),

                SizedBox(
                  height: 8,
                ),
                TextField(
                  onSubmitted: (text) async {
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Title",
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),

                SizedBox(
                  height: 28,
                ),

                Text("Type", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600
                ),),

                SizedBox(
                  height: 8,
                ),
                TextField(
                  onSubmitted: (text) async {
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Type",
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),


                SizedBox(
                  height: 28,
                ),

                Text("Pricec", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600
                ),),

                SizedBox(
                  height: 8,
                ),
                TextField(
                  onSubmitted: (text) async {
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Price",
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),


                SizedBox(
                  height: 28,
                ),

                Text("Contact Number", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600
                ),),

                SizedBox(
                  height: 8,
                ),
                TextField(
                  onSubmitted: (text) async {
                  },
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Number",
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),



                SizedBox(
                  height: 28,
                ),

                Text("Location", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600
                ),),

                SizedBox(
                  height: 8,
                ),
                TextField(
                  onSubmitted: (text) async {
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Location",
                    suffixIcon: Icon(Icons.my_location, color: Theme.of(context).accentColor),
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),


                SizedBox(
                  height: 28,
                ),

                Text("Details", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600
                ),),

                SizedBox(
                  height: 8,
                ),
                TextField(
                  onSubmitted: (text) async {
                  },
                  maxLines: 4,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Details",
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
