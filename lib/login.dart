import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = "";
  String _password = "";

  Future loginmethod() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.pushNamed(context, 'home');
    } on FirebaseAuthException catch (e) {
      /*
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No user found for that email")));
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Wrong password provided for that user")));
      }
      */
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      backgroundColor: Color(0xFFA95C05),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 75,
                    color: Colors.white,
                    fontFamily: 'PatuaOne',
                  ),
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xFFD9D9D9),
            ),
            height: 310,
            width: 357,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 21),
                  height: 63,
                  width: 330,
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2E5171),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () => signInWithGoogle()
                        .then((value) => Navigator.pushNamed(context, 'home')),
                    child: Image(
                      image: AssetImage("assets/google.png"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 42),
                  child: SizedBox(
                    width: 330,
                    height: 63,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0),
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 330,
                    height: 63,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter your password",
                      ),
                      onChanged: (value) => _password = value,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(210, 15, 0, 0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Forgot Password",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, 'forgotpass');
                            })
                    ]),
                  ),
                  /*
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => null,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                    )
                */
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 19),
            child: SizedBox(
              height: 50,
              width: 357,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF2E5171),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    )),
                onPressed: () {
                  loginmethod().then((value) => null);
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'PatuaOne',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account? ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, 'signup');
                      }),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
