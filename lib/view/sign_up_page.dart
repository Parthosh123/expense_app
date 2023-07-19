import 'package:expense_app/common_widgets/TextField.dart';
import 'package:expense_app/common_widgets/button.dart';
import 'package:expense_app/constants/constantAssets.dart';
import 'package:expense_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _username = '';
  String _password = '';
  String _email = '';
  String _phone = '';
  bool loading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  void _handleLogin() async {
    setState(() => loading = true);
    print('Username: $_email \nPassword: $_password');
    User? user;
    try {
      user = await auth
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((value) {
        user = value.user;
        if (user != null) {
          createData(user!);
        }
      }).catchError((val) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("This email Id is already registered"),
        ));
        setState(() => loading = false);
      });
    } finally {
      setState(() => loading = false);
    }
  }

  void createData(User user) {
    databaseReference.child("expense tracker").child(user.uid).child("profile").set({
      'id': user.uid,
      'name': _username,
      'phone': _phone,
      'email': user.email,
      'password': _password,
    });
    setState(() => loading = false);
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
                    Center(child: Lottie.asset(ConstantAssets.anim2, width: 280.0)),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 36.0, color: Colors.black, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFieldWidget(
                      controller: username,
                      enterHint: "Username",
                      onChanged: (val) {
                        setState(() {
                          _username = val;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFieldWidget(
                      inputType: TextInputType.emailAddress,
                      controller: email,
                      enterHint: "Email",
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFieldWidget(
                      inputType: TextInputType.number,
                      controller: phone,
                      enterHint: "Phone",
                      onChanged: (val) {
                        setState(() {
                          _phone = val;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
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
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                          TextSpan(
                            text: "By signing up, you're agree to our ",
                            style: TextStyle(fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: " Terms & Conditions ",
                            style: TextStyle(fontSize: 13.0, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: " Privacy policy ",
                            style: TextStyle(fontSize: 13.0, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                          ),
                        ])),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: OutlinedButtonWidget(
                        fontSize: 16.0,
                        color: Colors.deepPurple,
                        minHeight: MediaQuery.of(context).size.height * 0.05,
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        press: _handleLogin,
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                text: "Joined us before ? ",
                                style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "Login ",
                                style: TextStyle(fontSize: 16.0, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                              ),
                            ])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
