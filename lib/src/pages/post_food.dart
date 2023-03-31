
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Loc;
import 'package:markets/src/elements/BlockButtonWidget.dart';
import 'package:markets/src/elements/PermissionDeniedWidget.dart';
import 'package:markets/src/helpers/custom_trace.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/helpers/maps_util.dart';
import 'package:markets/src/models/address.dart';
import 'package:markets/src/repository/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


class PostFood extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
   PostFood({Key key,this.parentScaffoldKey}) : super(key: key);

  @override
  State<PostFood> createState() => _PostFoodState();
}

class _PostFoodState extends State<PostFood> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();

  bool loading = false;
  String type;
  bool emptyType= false;

  @override
  void initState() {
    // TODO: implement initState
    showCurrentLocation();
    super.initState();
  }

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
        child:
        currentUser.value.apiToken == null
            ? PermissionDeniedWidget() :
        Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12
                  ),
                  child: Form(
                    key: formKey,
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
                        TextFormField(
                          autofocus: false,
                          controller: _titleController,
                          validator: (text){
                            if(text.isEmpty){
                              return "Title cannot be empty";
                            }
                            else{
                              return null;
                            }
                          },
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

                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(context).focusColor.withOpacity(0.1),
                            )
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton(
                            value: type,
                            hint:  Text("Select type",style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),),
                            items: ["Free","Paid"].map((e) => DropdownMenuItem(
                               value: e,
                              child: Text(e,style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),),
                            )).toList(),
                            onChanged: (input){
                              setState(() {
                                 type = input;
                                 emptyType = false;
                              });
                            },
                            underline: SizedBox(),
                            isExpanded:true,
                          ),
                        ),

                        emptyType?Text("Type can not be empty",style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.red
                        ),):Container(),


                        if(type == "Paid")...[
                          SizedBox(
                            height: 28,
                          ),

                          Text("Price", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600
                          ),),

                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            validator: (text){
                            if(text.isEmpty){
                              return "Price cannot be empty";
                            }
                            else{
                              return null;
                            }
                          },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(12),
                              hintText: "Price",
                              hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                            ),
                          ),

                        ],



                        SizedBox(
                          height: 28,
                        ),

                        Text("Contact Number", style: Theme.of(context).textTheme.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600
                        ),),

                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: _numberController,
                          validator: (text){
                            if(text.isEmpty){
                              return "Number cannot be empty";
                            }
                            else{
                              return null;
                            }
                          },
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
                        TextFormField(
                          autofocus: false,
                          controller: _locationController,
                          validator: (text){
                            if(text.isEmpty){
                              return "Location cannot be empty";
                            }
                            else{
                              return null;
                            }
                          },
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
                        TextFormField(
                          autofocus: false,
                          controller: _detailsController,
                          validator: (text){
                            if(text.isEmpty){
                              return "Details cannot be empty";
                            }
                            else{
                              return null;
                            }
                          },
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Details",
                            hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                          ),
                        ),


                        SizedBox(height: 20),

                        loading?Center(child: CircularProgressIndicator(),):
                        SizedBox(
                          width: double.infinity,
                          child: BlockButtonWidget(
                            text: Text(
                              "Submit",
                              style:
                              TextStyle(color: Theme.of(context).primaryColor),
                            ),

                            color: Theme.of(context).accentColor,
                            onPressed: () {


                              if(formKey.currentState.validate()){
                                postFoodItem();
                              }
                              else{
                                setState(() {
                                  if(type == null){
                                    emptyType = true;
                                    return;
                                  }
                                  else{
                                    emptyType = false;
                                  }
                                });
                              }

                            },
                          ),
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            ),

          /*  loading?Center(
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5)
                  ),
                  child: CircularProgressIndicator()),
            ):Container()*/
          ],
        ),
      ),
    );
  }



  Future<dynamic> showCurrentLocation() async {
    Loc.Location location =  Loc.Location();
    MapsUtil mapsUtil = new MapsUtil();
    final whenDone = new Completer();
    Address _address = new Address();
    location.requestService().then((value) async {
      location.getLocation().then((_locationData) async {
        List<Placemark> newPlace = await placemarkFromCoordinates(_locationData?.latitude, _locationData?.longitude);
        // this is all you need
        Placemark placeMark  = newPlace[0];
        String name = placeMark.name;
        String subLocality = placeMark.subLocality;
        String locality = placeMark.locality;
        String administrativeArea = placeMark.administrativeArea;
        String postalCode = placeMark.postalCode;
        String country = placeMark.country;
        String address = "${subLocality}, ${locality}, $country";
        _locationController.text = address;
        setState(() { });
        whenDone.complete(_address);
      }).timeout(Duration(seconds: 10), onTimeout: () async {
        whenDone.complete(_address);
        return null;
      }).catchError((e) {
        whenDone.complete(_address);
      });
    });
    return whenDone.future;
  }

  Future<void> postFoodItem() async {

    setState(() {
       if(type == null){
         emptyType = true;
         return;
       }
       else{
         emptyType = false;
       }
    });

    Uri uri = Helper.getUri('api/add_sharefood');
    try {
      setState(() {
        loading = true;
      });

      Map body  = {
        "user_id":currentUser.value.id,
        "title":_titleController.text.trimRight(),
        "type":type,
        "price":_priceController.text.trimRight(),
        "contact_number":_numberController.text.trimRight(),
        "location":_locationController.text.trimRight(),
        "details":_detailsController.text.trimRight(),
      };

      print("body : ${body}");

      var response = await http.post(uri,body: body);
      print("add food res: ${response.statusCode} -- ${response.body}");

      if(response.statusCode == 200){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          showCancelBtn: false,
          title: "Food added successfully",
          confirmBtnText: "Done",
          confirmBtnColor: Theme.of(context).accentColor,
          confirmBtnTextStyle: Theme.of(context).textTheme.bodyMedium,
          onConfirmBtnTap: (){
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
          }
        );

        //clear fields
        _titleController.text = "";
        _typeController.text = "";
        _priceController.text = "";
        _numberController.text = "";
        _detailsController.text = "";
      }
      setState(() {
        loading = false;
      });
      return response;
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(CustomTrace(StackTrace.current, message: e.toString()).toString());
      return null;
    }
  }

}
