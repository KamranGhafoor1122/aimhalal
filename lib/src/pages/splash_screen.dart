import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/splash_screen_controller.dart';
import '../repository/settings_repository.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;

  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    _con.progress.addListener(() {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
      });
      if (progress == 100) {
        try {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
        } catch (e) {

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff057906),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("AimHalal",style: Theme.of(context).textTheme.displayLarge.copyWith(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                  ),),
                  SizedBox(height: 2),
                  Text("Halal Holistic Lifestyle",style: Theme.of(context).textTheme.displayLarge.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  ),),
                ],
              ),
            ),


            Align(
              alignment: Alignment.bottomCenter,
              child:  Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text("Made with love in  Canada ❤",style: Theme.of(context).textTheme.displayLarge.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
