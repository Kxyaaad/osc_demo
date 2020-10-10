abstract class AppColors {
  static const AppTheme = 0xff63ca6c;
  static const APPBAR = 0xfffffffff;
}

abstract class AppInfoes {
  static const String CLIENT_ID = 'bcacW4vic6Z5ZIhAew0C';
  static const String CLIENT_SECRET = 'xoE6Sauna7X7Le6VgEfsaMtUfS1IIqV4';
  static const String REDIRECT_URI = 'https://www.baidu.com/';
}

abstract class AppUrls {
  static const String HOST = 'https://www.oschina.net';

  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';
  static const String OPENAPI_USER =
      HOST + '/action/openapi/user'; // 获取用户信息

  static const String MY_INFORMATION = HOST + '/action/openapi/my_information'; //我的资料详情
  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';
  static const String NEWS_LIST = HOST +'/action/openapi/news_list';
}
