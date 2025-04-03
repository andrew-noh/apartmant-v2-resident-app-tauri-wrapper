import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:window_size/window_size.dart' as window_size;
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    window_size.setWindowTitle('아파트먼트 V2');
    window_size.setWindowMinSize(const Size(360, 740));
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MobileBrowser(),
    );
  }
}

class MobileBrowser extends StatefulWidget {
  const MobileBrowser({super.key});

  @override
  State<MobileBrowser> createState() => _MobileBrowserState();
}

class _MobileBrowserState extends State<MobileBrowser> {
  late final WebViewController controller;
  final String initialUrl = 'https://residentapp.apartmant.co.kr/';

  @override
  void initState() {
    super.initState();
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setUserAgent(
            'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1',
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onWebResourceError: (WebResourceError error) {
                print('Error loading webpage: ${error.description}');
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
          )
          ..enableZoom(false)
          ..loadRequest(Uri.parse(initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: 360,
          height: 740,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade800),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: WebViewWidget(controller: controller),
            ),
          ),
        ),
      ),
    );
  }
}
