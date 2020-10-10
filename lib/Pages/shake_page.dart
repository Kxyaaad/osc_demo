import 'package:flutter/material.dart';

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShaked = false;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
