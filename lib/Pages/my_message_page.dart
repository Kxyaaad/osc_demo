import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osc_demo/constants/constants.dart';
import 'package:osc_demo/utils/data_utils.dart';
import 'package:osc_demo/utils/net_util.dart';

class MyMessagePage extends StatefulWidget {
  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  List<String> _tabTitles = ['@我', '评论', '私信'];
  int currentPage = 1;
  List messageList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '消息中心',
            style: TextStyle(color: Color(AppColors.APPBAR)),
          ),
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
          bottom: TabBar(
              tabs: _tabTitles
                  .map((title) => Tab(
                        text: title,
                      ))
                  .toList()),
        ),
        body: TabBarView(children: [
          Center(
            child: Text('暂无内容'),
          ),
          Center(
            child: Text('暂无内容'),
          ),
          _buildMessageList()
        ]),
      ),
    );
  }

  Future<Null> _pullToRefresh() async{
    currentPage = 1;
    getMessageList();
    return  null;
  }

  _buildMessageList() {
    if (messageList == null) {
      //获取私信列表
      getMessageList();

      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return RefreshIndicator(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.network(messageList[index]['portrait']),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${messageList[index]['sendername']}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${messageList[index]['pubDate']}',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffaaaaaa)),
                              ),
                            ],
                          ),
                          Text(
                            '${messageList[index]['content']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: messageList.length),
        onRefresh: _pullToRefresh);
  }

  void getMessageList() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['page'] = currentPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';
          NetUtils.get(AppUrls.MESSAGE_LIST, params).then((data) {
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              var _messageList = map['messageList'];
              setState(() {
                messageList = _messageList;
              });
            }
          });
        });
      }
    });
  }
}
