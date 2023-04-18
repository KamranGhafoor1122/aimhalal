/*
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';


class RideLocationPage extends StatefulWidget {
  const RideLocationPage({Key key}) : super(key: key);

  @override
  State<RideLocationPage> createState() => _RideLocationPageState();
}

class _RideLocationPageState extends State<RideLocationPage> {

  Position currentPosition;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  GoogleMapController mapController;

  String setLocationOnMap;

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      initializeComponent();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: size.width,
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            icon: Icon(Icons.arrow_back_outlined, size: 30,color: Theme.of(context).hintColor,)),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            color: Theme.of(context).accentColor,
                            width: 10,
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            color: Theme.of(context).accentColor,
                            width: 2,
                            height: 50,
                          ),
                            Container(
                              color: Theme.of(context).accentColor,
                              width: 10,
                              height: 10,
                            ),


                          ],),
                        SizedBox(width: 20,),
                        Column(
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap:() async {
                                    print("kddk");
                                    Prediction p = await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey: "AIzaSyDsgnI6XM21K2-vnkjpXUD-LjnfXpxAXWU",
                                        hint: 'Search Pickup Address',

                                        mode: Mode.overlay, // Mode.fullscreen
                                        language: "en",
                                      types: [], components: [new Component(Component.country, "pak")],
                                      strictbounds: false,
                                    );
                                    if(p!=null){
                                      displayPrediction(p,true);
                                      // var addresses = await Geocoder.local.findAddressesFromQuery(pickupAddress!.description);
                                    }
                                    print("pick up location select is: ${p?.toJson()}");

                                   },
                                  child: Container(
                                    width: size.width*0.8,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5,),
                                        SizedBox(
                                          width: size.width*0.7,
                                          child: Text("search location",maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodySmall,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    top: 10,
                                    child: GestureDetector(
                                      onTap: (){
                                        if(setLocationOnMap=="pickUp"){
                                          setLocationOnMap=null;
                                        }else{
                                          setLocationOnMap="pickUp";
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color:(setLocationOnMap!=null && setLocationOnMap=="pickUp")? Colors.black.withOpacity(0.5):Colors.transparent,
                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                        ),
                                        child: Icon(Icons.pin_drop,size: 15,),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                ),
                Expanded(
                    child: Container(
                      width: size.width,
                    child:  Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex,

                            onCameraIdle: () async {
                              LatLngBounds bounds = await mapController?.getVisibleRegion();
                              final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
                              final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
                              print("LatLngBounds: $lat $lon");
                              String address= await CommonFunctions().getAddressFromLatLongs(lat,lon);
                              print("address is: $address");
                              if(setLocationOnMap!=null){
                                LocationModel model=LocationModel(location: address,long: lon,lat: lat);
                                if(setLocationOnMap=="pickUp"){
                                  pickupAddress=model;
                                }else{
                                  destinationAddress=model;
                                }
                                setState(() {});
                              }
                            },
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            mapController=controller;

                          },
                          markers: Set<Marker>.of(markers.values),

                        ),
                        (setLocationOnMap!=null)? Center(
                          child: Image.asset("assets/images/pin.png",width: 55,),
                        ):Container()
                      ],
                    ),
                    )),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.all(20),
                  child: buttonWidget(context: context, text: 'Done',height: 55, color: primaryColor,onPress: () async {

                    if(pickupAddress!=null && destinationAddress!=null){
                      loadingAlertDialog(context: context);
                      HomeProvider homeProvider= Provider.of<HomeProvider>(context,listen: false);
                      homeProvider.suggestionList.insert(0,destinationAddress!);
                      homeProvider.suggestionList = homeProvider.suggestionList.take(6).toList();
                      await HomeService().updateRideRequestStatus(userDetail!.uid!,homeProvider.suggestionList as  List<LocationModel>);
                      homeProvider.notifyListeners();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  RideCategoryPage(pickupLocation: pickupAddress!, destinationLocation: destinationAddress!,)),
                      );
                    }

                  })),
            ),
            Positioned(
              right: 10,
              bottom: 90,
              child: Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: IconButton(onPressed:getCurrentLocation, icon: Icon(Icons.my_location_sharp,size: 25,color: primaryColor,),)),
            )
          ],
        ),
      ),
    );
  }
  mapNavigateOnPoints(double lat,double long) async {
    CameraPosition _kLake = CameraPosition(
      // bearing: 192.8334901395799,
        target: LatLng(lat,long),
        // tilt: 59.440717697143555,
        zoom: 15);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  displayPrediction(Prediction? p,bool pickUpLocation) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: Constant.kGoogleMapKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );

      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId??"");

      var placeId = p.placeId;
    double? lat = detail.result.geometry?.location.lat;
    double? long = detail.result.geometry?.location.lng;
      var address  =detail.result.formattedAddress;
      if(pickUpLocation){
        pickupAddress=LocationModel(location: address,lat: lat,long: long);

      }else{
        destinationAddress=LocationModel(location: address,lat: lat,long: long);

      }

      print("lat is: $lat");
      print("long is: $long");
      if(lat!=null && long!=null){
        await add(lat,long,address);
        mapNavigateOnPoints(lat,long);
      }
      setState(() {});
    }
  }
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

   add(double lat, double long,String? address) async {
    int markerIdVal = 123;
    final MarkerId markerId = MarkerId(markerIdVal.toString());

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        lat,
        long,
      ),
      infoWindow: InfoWindow(title: "address", snippet: address),
      onTap: () {
      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

   initializeComponent() async {
     await getCurrentLocation();
   }

   getCurrentLocation() async{
     await CommonFunctions().permissionServices().then(
           (value) async {
         if (value.isNotEmpty) {
           print("status location: $value");
           if (value[Permission.location]?.isGranted == true) {
             */
/* ========= New Screen Added  ============= *//*

             var status = await Permission.location.serviceStatus;
             if (status.isEnabled) {
               currentPosition = await CommonFunctions().getCurrentLocation();
               String? address = await CommonFunctions().GetAddressFromLatLong(currentPosition!);
               pickupAddress= LocationModel(lat:currentPosition?.latitude,location: address,long:currentPosition?.longitude);
               if(currentPosition!=null){
                 await add(currentPosition!.latitude,currentPosition!.longitude,address);
                 mapNavigateOnPoints(currentPosition!.latitude,currentPosition!.longitude);
               }
             } else {
               currentPosition = await CommonFunctions().getCurrentLocation();
               if(currentPosition!=null) {
                 String? address = await CommonFunctions()
                     .GetAddressFromLatLong(currentPosition!);
                 pickupAddress = LocationModel(
                     lat: currentPosition?.latitude,
                     location: address,
                     long: currentPosition?.longitude);
                 mapNavigateOnPoints(currentPosition!.latitude,
                     currentPosition!.longitude);
               }
             }
           }
           if(value[Permission.location]?.isDenied ==true||value[Permission.location]?.isPermanentlyDenied==true){
             await openAppSettings();
           }
         }
       },
     );
   }
}
*/
