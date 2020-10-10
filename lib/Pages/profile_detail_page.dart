import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osc_demo/constants/constants.dart';
import 'package:osc_demo/models/user_info.dart';
import 'package:osc_demo/utils/data_utils.dart';
import 'package:osc_demo/utils/net_util.dart';

class profileDetailPage extends StatefulWidget {
  @override
  _profileDetailPageState createState() => _profileDetailPageState();
}

class _profileDetailPageState extends State<profileDetailPage> {
  UserInfo _userInfo;
  Map<String, dynamic> _map = new Map<String, dynamic>();
  String _avatar;
  Map<String, String> titles = {
    '头像': 'avatar',
    '昵称': 'name',
    '加入时间': 'joinTime',
    '所在地区': 'city',
    '开发平台': 'platforms',
    '专长领域': 'expertise',
    '粉丝数': 'followersCount',
    '收藏数':'favoriteCount',
    '':''
  };

  _getDetailInfo() {
    DataUtils.getAccessToken().then((accessToken) {
      //拼装请求
      Map<String, dynamic> params = Map<String, dynamic>();
      params['dataType'] = 'json';
      params['access_token'] = accessToken;
      NetUtils.get(AppUrls.MY_INFORMATION, params).then((data) {
        print('我的个人信息 $data');
        if (data != null && data.isNotEmpty) {
          Map<String, dynamic> map = json.decode(data);
          print(map['uid']);
          UserInfo userInfo = UserInfo();
          userInfo.uid = map['uid'];
          userInfo.name = map['name'];
          userInfo.gender = map['gender'];
          userInfo.province = map['province'];
          userInfo.city = map['city'];
          userInfo.platforms = map['platforms'];
          userInfo.expertise = map['expertise'];
          userInfo.joinTime = map['joinTime'];
          userInfo.lastLoginTime = map['lastLoginTime'];
          userInfo.portrait = map['portrait'];
          userInfo.fansCount = map['fansCount'];
          userInfo.favoriteCount = map['favoriteCount'];
          userInfo.followersCount = map['followersCount'];
          userInfo.notice = map['notice'];

          setState(() {
            _userInfo = userInfo;
            _map = map;
          });
        }
      });
    });

    DataUtils.getUserInfo().then((value) {
      setState(() {
        _avatar = value.avatar;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDetailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '个人详情',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: Container(
        child: _userInfo == null
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Row(
                      children: [
                        Container(
                          child: Text(titles.keys.toList()[index]),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        ),
                        Container(
                          child: Image.network(_avatar),
                          padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                        ),
                      ],
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    );
                  } else {
                    return Row(
                      children: [
                        Container(
                          child: Text(titles.keys.toList()[index]),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        ),

                        Container(
                          child: Text(_map[titles.values.toList()[index].toString()].toString() == '[]' ? '暂无记录' : _map[titles.values.toList()[index].toString()].toString()),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    );
                  }
                },
                itemCount: titles.length,
              ),
      ),
    );
  }
}
