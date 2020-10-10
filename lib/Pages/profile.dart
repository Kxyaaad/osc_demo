import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:osc_demo/Pages/login_web_page.dart';
import 'package:osc_demo/Pages/my_message_page.dart';
import 'package:osc_demo/Pages/profile_detail_page.dart';
import 'package:osc_demo/common/eventBus.dart';
import 'package:osc_demo/constants/constants.dart';
import 'package:osc_demo/utils/data_utils.dart';
import 'package:osc_demo/utils/net_util.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = ['我的消息', '阅读记录', '我的博客', '我的问答', '我的活动', '我的团队', '邀请好友'];
  List menuIcons = [
    Icons.message,
    Icons.record_voice_over,
    Icons.art_track,
    Icons.question_answer,
    Icons.accessibility_new,
    Icons.work,
    Icons.share,
  ];
  String userAvatar;
  String userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //尝试显示用户信息
    _showUserInfo();

    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息并显示
      _getUserInfo();
    });

    eventBus.on<LogoutEvent>().listen((event) {
      //TODO
    });
  }

  _showUserInfo() {
    DataUtils.getUserInfo().then((user) {
      if (mounted) {
        if (user != null) {
          print("已经存储了信息");
          setState(() {
            userAvatar = user.avatar;
            userName = user.name;
          });
        } else {
          print("尚未登录");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildContainer();
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin) {
                if (isLogin) {
                  switch (index) {
                    case 0:
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyMessagePage()));
                      break;
                  }
                } else {
                  _login();
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: menuTitles.length + 1);
  }

  //登录
  _login() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    if (result != null && result == 'refresh') {
      //登录成功
      eventBus.fire(LoginEvent()); //通知登录成功事件
      print('登录回调');
    }
  }

  _getUserInfo() {
    DataUtils.getAccessToken().then((value) {
      if (value == null || value.length == 0) {
        return;
      }

      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = value;
      params['dataType'] = 'json';

      NetUtils.get(AppUrls.OPENAPI_USER, params).then((data) {
        print('data: $data');

        var map = json.decode(data);
        if (mounted) {
          setState(() {
            userAvatar = map['avatar'];
            userName = map['name'];
          });
        }
        DataUtils.saveUserInfo(map);
      });
    });
  }

  Container _buildContainer() {
    return Container(
      color: Color(AppColors.AppTheme),
      height: 150,
      child: Center(
        child: Column(
          //头像
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                          userAvatar == null
                              ? 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598596590180&di=9117a5e1b0e41ed72207e4a8249ae60f&imgtype=0&src=http%3A%2F%2Fimg1.v.tmcdn.net%2Fimg%2Fh000%2Fh07%2Fimg201208201742420.jpg'
                              : userAvatar,
                        ),
                        fit: BoxFit.cover)),
              ),
              onTap: () {
                DataUtils.isLogin().then((isLogin) {
                  if (isLogin) {
                    //跳转详情
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => profileDetailPage()));
                  } else {
                    _login();
                  }
                });
              },
            ),
            Text(
              userName == null ? '点击头像登录' : userName,
              style: TextStyle(color: Colors.white),
            )
          ],
          //用户名
        ),
      ),
    );
  }
}
