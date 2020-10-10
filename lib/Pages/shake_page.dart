import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShaked = false;
  int _currentIndex = 0;
  StreamSubscription _streamSubscription;
  static const int SHAKE_TIMEOUT =  500;
  static const double SHAKE_THRESHOLD = 3.5;
  var _lastTime = 0;

  @override
  void initState() {
  // TODO: implement initState
  super.initState();
  _streamSubscription = accelerometerEvents.listen((event) {
    var now = DateTime.now().millisecondsSinceEpoch;
    if ((now - _lastTime) > SHAKE_TIMEOUT) {
      var x = event.x;
      var y = event.y;
      var z = event.z;

      double acce = sqrt(x*x+y*y+z*z)-9.8;
      if (acce > SHAKE_THRESHOLD){
        //手机晃动了
        _lastTime = now;
        if(!mounted) return;
        setState(() {
          isShaked = true;
        });
      }
    }
  });

  }
  @override
  void dispose() {
  // TODO: implement dispose
  super.dispose();
  _streamSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text(
  '摇一摇',
  style: TextStyle(color: Colors.white),
  ),
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.white),
  ),
  body: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Image.asset(
  'assets/images/yaoyiyao.png',
  width: 120,
  height: 120,
  ),
  Text('摇一摇抢礼品')
  ],
  ),
  ),
  bottomNavigationBar: BottomNavigationBar(
  items: [
  BottomNavigationBarItem(
  icon: Icon(Icons.card_giftcard), title: Text('礼品')),
  BottomNavigationBarItem(
  icon: Icon(Icons.format_indent_increase), title: Text('资讯'))
  ],
  currentIndex: _currentIndex,
  onTap: (index) {
  if(!mounted) return;
  setState(() {
  _currentIndex = index;
  });
  },
  ),
  );
  }
}
