import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Signup());
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email = "";
  String _password = "";
  String conf_password = "";

  Future signupmethod() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
      /*
      if (e.code == "ERROR_CREDENTIAL_ALREADY_IN_USE") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Account already exists")));
      }
      */
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
    return Scaffold(
      backgroundColor: Color(0xFFA95C05),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text(
                  "SIGN UP",
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
            height: 375,
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
                    onPressed: () {
                      signInWithGoogle().then(
                          (value) => Navigator.pushNamed(context, 'home'));
                    },
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
                        hintText: "Confirm your password",
                      ),
                      onChanged: (value) => conf_password = value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Already Have An Account? ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5))),
                      TextSpan(
                          text: "Login",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.5),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, 'login');
                            }),
                    ]),
                  ),
                  /*
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF000000).withOpacity(0.5),
                      ),
                    ),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(context, "login"),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )),
                  ],
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
                  if (_password == conf_password) {
                    signupmethod()
                        .then((value) => Navigator.pushNamed(context, 'home'));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password does not match")));
                  }
                },
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'PatuaOne',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
        appBar: AppBar(
          title: Text("Practice App"),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
*/