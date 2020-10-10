import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:osc_demo/constants/constants.dart';

class CommonWebPage extends StatefulWidget {
  final String title;
  final String url;

  CommonWebPage({Key key,this.title, this.url})
      : assert(title != null),
        assert(url != null),
        super(key: key);

  @override
  _CommonWebPageState createState() => _CommonWebPageState();
}

class _CommonWebPageState extends State<CommonWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        widget.title,
        style: TextStyle(
          color: Color(AppColors.APPBAR),
        ),
      )
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(width: 10,));
      _appBarTitle.add(CupertinoActivityIndicator());
    }
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
