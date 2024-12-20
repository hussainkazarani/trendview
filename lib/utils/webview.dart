import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  final String url;

  const WebViewTest({super.key, required this.url});

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Use widget.url here because initState has access to widget's properties.
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Test'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

//Navigator.of(context).pushNamed('/webViewTest')
