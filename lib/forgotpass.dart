import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class forgotpass extends StatefulWidget {
  const forgotpass({super.key});

  @override
  State<forgotpass> createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  @override
  String _email = "";
  Future emailReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email sent")));
      Navigator.pushNamed(context, 'login');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA95C05),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 19),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xFFD9D9D9),
            ),
            height: 250,
            width: 357,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Reset your password",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'PatuaOne',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter your e-mail",
                      ),
                      onChanged: (value) => _email = value,
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Go Back To Login Page",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, 'login'))
                ])),
              ],
            ),
          ),
          SizedBox(
            width: 357,
            height: 50,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E5171),
              ),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: 'PatuaOne',
                ),
              ),
              onPressed: () => emailReset().then((value) => null
                  /*
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Email sent")))
              */
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
