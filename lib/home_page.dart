import 'package:flutter/material.dart';
import 'package:osc_demo/Pages/discovery_page.dart';
import 'package:osc_demo/Pages/news_list_page.dart';
import 'package:osc_demo/Pages/profile.dart';
import 'package:osc_demo/Pages/tweet_page.dart';
import 'package:osc_demo/widgets/NagitionIconView.dart';
import 'package:osc_demo/widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appBarTitle = ['资讯', '动弹', '发现', '我的'];
  List<NavigationIconView> _navigationIconViews;
  var _currentIndex = 0;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationIconViews = [
      NavigationIconView(
          title: '资讯',
          iconPath: 'assets/images/renwu_1.png',
          actionIconPath: 'assets/images/renwu.png'),
      NavigationIconView(
          title: '动弹',
          iconPath: 'assets/images/tongji_1.png',
          actionIconPath: 'assets/images/tongji.png'),
      NavigationIconView(
          title: '发现',
          iconPath: 'assets/images/renwu_1.png',
          actionIconPath: 'assets/images/renwu.png'),
      NavigationIconView(
          title: '我的',
          iconPath: 'assets/images/wode_1.png',
          actionIconPath: 'assets/images/wode.png'),
    ];

    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      ProfilePage()
    ];

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //TODO 标题
          title: Text(
            _appBarTitle[_currentIndex],
            style: TextStyle(color: Colors.white),
          ),
          // shadowColor: Color(00000000000),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: PageView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
          physics: NeverScrollableScrollPhysics(), //控制翻页
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: _navigationIconViews.map((e) => e.item).toList(),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            //TODO
            setState(() {
              _currentIndex = index;
            });
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 1), curve: Curves.ease);
          },
        ),
        drawer: MyDrawer(
            headImagePath: 'assets/images/DrawerBanner.jpg',
            menuTitles: ['发布动态', '动弹小黑屋', '关于', '设置'],
            menuIcons: [Icons.send, Icons.block, Icons.info, Icons.settings]));
  }
}
