import 'package:expense_app/common_widgets/TextField.dart';
import 'package:expense_app/common_widgets/button.dart';
import 'package:expense_app/constants/constantAssets.dart';
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
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  void _handleLogin() {
    print('Username: $_username\nPassword: $_password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
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
                enterHint: "Email",
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
                  onTap: (){
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
