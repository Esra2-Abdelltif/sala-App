import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salaa_app/shared/Styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVeiwScreen extends StatelessWidget {
   final String url;

  WebVeiwScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: defultColor,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
        centerTitle: true,),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
