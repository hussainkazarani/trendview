import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/login_pages/login.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/webview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NewsProviders())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const Login(),
          '/webViewTest': (context) => const WebViewTest(
                url: '',
              ),
        },
      ),
    );
  }
}
