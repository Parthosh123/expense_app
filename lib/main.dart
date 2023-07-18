import 'package:flutter/material.dart';

import 'view/login_page.dart';

//github token
//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

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: LoginPage()),
    );
  }
}
