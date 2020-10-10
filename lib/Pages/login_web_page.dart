import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:osc_demo/constants/constants.dart';
import 'package:osc_demo/utils/data_utils.dart';
import 'package:osc_demo/utils/net_util.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLOading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听url变化
    _flutterWebviewPlugin.onUrlChanged.listen((event) {
      print('LoginWebPage onUrlChanged: $event');
      if (mounted) {
        setState(() {
          isLOading = false;
        });
      }

      //https://www.baidu.com/?code=nRqvMi&state=
      if(event != null && event.length > 0 && event.contains('?code=')) {
        //登录成功

        //提取授权码code
        String code = event.split('?')[1].split('&')[0].split('=')[1];

        Map<String, dynamic> params = Map<String, dynamic>();
        params['client_id'] = AppInfoes.CLIENT_ID;
        params['client_secret'] = AppInfoes.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfoes.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';

        print('提交参数 $params');

        NetUtils.get(AppUrls.OAUTH2_TOKEN, params)
          .then((value) {
            print('获取数据 $value');
            if (value != null) {
              Map<String, dynamic> map = json.decode(value);
              if (map !=null && map.isNotEmpty) {
                //保存token等信息
                DataUtils.saveLoginInfo(map);
                //登录成功，返回上层页面，发送通知'refresh'， 刷新数据
                Navigator.pop(context, 'refresh');
              }
            }
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(color: Colors.white),
      ),
    ];

    if(isLOading) {
      _appBarTitle.add(SizedBox(width: 10,));
      _appBarTitle.add(CupertinoActivityIndicator());
    }



    return WebviewScaffold(
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppInfoes.CLIENT_ID +
          '&redirect_uri=' +
          AppInfoes.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
      ),
      withJavascript: true, // 允许执行js
      withLocalStorage: true, //允许本地存储
      withZoom: true, //允许网页缩放

    );
  }

}
