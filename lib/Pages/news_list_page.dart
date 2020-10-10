import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osc_demo/Pages/login_web_page.dart';
import 'package:osc_demo/common/eventBus.dart';
import 'package:osc_demo/constants/constants.dart';
import 'package:osc_demo/utils/data_utils.dart';
import 'package:osc_demo/utils/net_util.dart';
import 'package:osc_demo/widgets/NewsListItem.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int currentPage = 1;
  List newsList = [];

  @override
  void initState() {
    // TODO: implement initState

    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        if (!mounted) return;
        setState(() {
          isLogin = true;
        });
        getNewsList(false);
      }
    });

    super.initState();

    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        isLogin = true;
      });
      //获取新闻列表
      getNewsList(false);
    });

    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        isLogin = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin == false) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('请先登录'),
            InkWell(
              onTap: () async {
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginWebPage()));
                if (result != null && result == 'refresh') {
                  eventBus.fire(LoginEvent());
                }
              },
              child: Text('登录'),
            )
          ],
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () {
          //TODO
          _pullToRefresh();
        },
        child: buildListView(),
      );
    }


  }

  Widget buildListView() {
    if(newsList == null){
      getNewsList(false);
      return CupertinoActivityIndicator();
    };
    return ListView.builder(itemBuilder: (context, index) {
        return NewsListItem(
          newsList: newsList[index],
        );
      });
  }

  void getNewsList(bool isLoadMore) async {
    DataUtils.getAccessToken().then((accessToken) {
      if (accessToken == null || accessToken.length == 0) {
        return;
      }
      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = accessToken;
      params['catalog'] = 1;
      params['page'] = currentPage;
      params['pageSize'] = 10;
      params['dataType'] = 'json';

      NetUtils.get(AppUrls.NEWS_LIST, params).then((data) {
        if (data != null && data.isNotEmpty) {
          print(data);
          Map<String, dynamic> map = json.decode(data);
          List _newsList = map['newslist'];
          if (!mounted) return;
          setState(() {
            newsList.addAll(_newsList);
          });
        }
      });
    });
  }

  Future<Null> _pullToRefresh() async {
    currentPage = 1;
    getNewsList(false);
    return null;
  }
}
