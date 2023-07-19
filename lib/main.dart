import 'package:expense_app/constants/constantAssets.dart';
import 'package:expense_app/controller/provider_controller.dart';
import 'package:expense_app/view/navbar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/login_page.dart';

//github token
//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

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ProviderController>(create: (_) => ProviderController()),
];

final FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();
late SharedPreferences localData;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: providers, child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userLoggedIn = false;

  @override
  void initState() {
    initial();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => userLoggedIn ? BottomNavBarPage() : LoginPage()));
    });
    // TODO: implement initState
    super.initState();
  }

  initial() async {
    localData = await SharedPreferences.getInstance();
    setState(() {
      userLoggedIn = localData.getBool("userLogged") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(ConstantAssets.anim1, width: 500.0),
      ),
    );
  }
}
