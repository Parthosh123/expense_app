import 'package:expense_app/common_widgets/TextField.dart';
import 'package:expense_app/common_widgets/button.dart';
import 'package:expense_app/constants/constantAssets.dart';
import 'package:expense_app/main.dart';
import 'package:expense_app/view/navbar_page.dart';
import 'package:expense_app/view/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  bool loading = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    initial();
    // TODO: implement initState
    super.initState();
  }

  initial() async {
    localData = await SharedPreferences.getInstance();
  }

  void _handleLogin() async {
    setState(() => loading = true);
    print('Username: $_email\nPassword: $_password');
    User? user;
    try {
      user = await auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
        user = value.user;
        if (user != null) {
          localData.setBool("userLogged", true);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavBarPage()));
          setState(() => loading = false);
        }
      }).catchError((val) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("The password or email id is invalid"),
        ));
        setState(() => loading = false);
      });
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      ConstantAssets.anim2,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 36.0, color: Colors.black, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFieldWidget(
                      controller: username,
                      enterHint: "email",
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                    ),
                    SizedBox(height: 15.0),
                    TextFieldWidget(
                      controller: password,
                      enterHint: "Password",
                      onChanged: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: OutlinedButtonWidget(
                        fontSize: 16.0,
                        color: Colors.deepPurple,
                        minHeight: MediaQuery.of(context).size.height * 0.05,
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        press: _handleLogin,
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 1.0,
                            width: 30.0,
                            color: Colors.grey,
                          ),
                          Text(
                            " or ",
                            style: TextStyle(fontSize: 20.0, color: Colors.grey, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: 2.0,
                            width: 30.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: OutlinedButtonWidget(
                        curveValue: 10.0,
                        fontSize: 16.0,
                        color: Colors.grey.shade200,
                        minHeight: MediaQuery.of(context).size.height * 0.05,
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        press: _handleLogin,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ConstantAssets.google,
                              height: 20.0,
                            ),
                            SizedBox(
                              width: 13.0,
                            ),
                            Text(
                              "Sign in with google",
                              style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                        child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                      },
                      child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                              text: "Need to Logistics ?",
                              style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: " Register ",
                              style: TextStyle(fontSize: 16.0, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                            ),
                          ])),
                    )),
                  ],
                ),
              ),
            ),
    );
  }
}
