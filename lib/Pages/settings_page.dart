import 'package:flutter/material.dart';
import 'package:osc_demo/common/eventBus.dart';
import 'package:osc_demo/constants/constants.dart';
import 'package:osc_demo/utils/data_utils.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            DataUtils.clearLoginInfo().then((value){
              eventBus.fire(LogoutEvent());
              Navigator.of(context).pop();
            });
          },
          child: Text(
            '退出登录',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
