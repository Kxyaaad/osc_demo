import 'package:flutter/material.dart';
import 'package:osc_demo/Pages/about.dart';
import 'package:osc_demo/Pages/publish_tweet.dart';
import 'package:osc_demo/Pages/settings_page.dart';
import 'package:osc_demo/Pages/tweet_black_house.dart';

class MyDrawer extends StatelessWidget {
  final String headImagePath;
  final List menuTitles;
  final List menuIcons;

  MyDrawer(
      {Key key,
      @required this.headImagePath,
      @required this.menuTitles,
      @required this.menuIcons})
      : assert(headImagePath != null),
        assert(menuTitles != null),
        assert(menuIcons != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        itemCount: menuTitles.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Image.asset(
              headImagePath,
              fit: BoxFit.cover,
            );
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              //TODO
              switch (index) {
                case 0:
                  _navPush(context, PublishTweetPage());
                  break;
                case 1:
                  _navPush(context, TweetBlackHousePage());
                  break;
                case 2:
                  _navPush(context, AboutPage());
                  break;
                case 3:
                  _navPush(context, SettingPage());
                  break;
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Divider(
              height: 0,
            );
          } else {
            return Divider(
              height: 1,
            );
          }
        },
      ),
    );
  }

  Future _navPush(BuildContext context, Widget page) {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
