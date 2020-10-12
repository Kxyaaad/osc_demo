import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:osc_demo/constants/constants.dart';
import 'package:osc_demo/utils/data_utils.dart';
import 'package:osc_demo/utils/net_util.dart';

class NewsDetailPage extends StatefulWidget {
  final int id;

  NewsDetailPage({this.id}) : assert(id != null);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isLoading = true;
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  String url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听URL变化
    _flutterWebviewPlugin.onStateChanged.listen((event) {
      if (event.type == WebViewState.finishLoad) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      } else if (event.type == WebViewState.startLoad) {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
      }
    });

    DataUtils.getAccessToken().then((token) {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = token;
      params['id'] = widget.id;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.NEWS_DETAIL, params).then((data) {
        if (data != null && data.isNotEmpty) {
          Map<String, dynamic> map = json.decode(data);
          if (!mounted) return;
          setState(() {
            url = map['url'];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitile = [
      Text(
        '资讯详情',
        style: TextStyle(
          color: Color(AppColors.APPBAR),
        ),
      )
    ];

    if (isLoading) {
      _appBarTitile.add(SizedBox(
        width: 10,
      ));
      _appBarTitile.add(CupertinoActivityIndicator());
    }

    return Container(
      color: Colors.white,
      child: url == null
          ? Center(
        child: CupertinoActivityIndicator(),
      )
          : WebviewScaffold(
        url: url,
        appBar: AppBar(
          title: Row(
            children: _appBarTitile,
          ),
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
        ),
        withJavascript: true,
        withLocalStorage: true,
        withZoom: true,
      ),
    );
  }
}
