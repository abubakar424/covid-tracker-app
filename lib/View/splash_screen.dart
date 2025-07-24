import 'dart:async';
import 'dart:math' as math;
import 'package:covid_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
late final AnimationController _controller =  AnimationController(vsync: this, duration:  Duration(seconds: 3) )..repeat() ;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose() ;
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStats()))
    ) ;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(animation: _controller, builder: (BuildContext context, Widget? child){
              return Transform.rotate(angle: _controller.value*math.pi , child: Container(
                height: 200,width: 200,
                child: Center(
                  child: Image(image: AssetImage('images/virus.png')),
                ),
              ),) ;
            }),
            SizedBox(height: MediaQuery.of(context).size.height*0.08),
            Align(
              alignment: Alignment.center,
              child: Text('Covid 19\nTracer App',textAlign: TextAlign.center,
                style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 25,
              ),),
            )

          ],
        ),
      ),
    );
  }
}
