import 'package:flutter/material.dart';
import 'package:markets/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';
class MyWebview extends StatefulWidget {
  String title;
  String url;
   MyWebview({Key key,@required this.title, @required this.url}) : super(key: key);

  @override
  State<MyWebview> createState() => _MyWebviewState();
}

class _MyWebviewState extends State<MyWebview> {
  bool pageLoading = true;
  WebViewController webView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: new IconButton(
          icon:
          new Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child:  WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) {
                  webView = controller;
                },
                onPageStarted: (String url) {
                 setState(() {
                   pageLoading = true;
                 });
                },
                onPageFinished: (String url) {
                  setState(() {
                    pageLoading = false;
                  });
                }),
          ),
          pageLoading?Center(child: CircularProgressIndicator()):Container()
        ],
      ),
    );
  }
}
