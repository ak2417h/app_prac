import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'forgotpass.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // bool loggedIn = FirebaseAuth.instance.currentUser != null;
  runApp(MaterialApp(
    // home: MyApp(),
    // /*
    debugShowCheckedModeBanner: false,
    initialRoute: FirebaseAuth.instance.currentUser != null ? 'home' : 'signup',
    routes: {
      'login': (context) => Login(),
      'signup': (context) => Signup(),
      'home': (context) => homepage(),
      'forgotpass': (context) => forgotpass(),
    },
    // */
  ));
}

/*
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url =
      Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    print('Number of books about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
*/