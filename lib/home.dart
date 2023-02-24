import 'dart:convert';
import 'dart:ffi';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(homepage());
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  String fn = "";
  String ln = "";
  String name = "";
  int ci = 0;

  // CollectionReference cr = FirebaseFirestore.instance.collection("user");

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }

  final user = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    List<Widget> wl = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
      Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "First Name",
                      ),
                      onChanged: (value) => setState(() {
                        fn = value;
                      }),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Last Name",
                      ),
                      onChanged: (value) => setState(() {
                        ln = value;
                      }),
                    ),
                    margin: EdgeInsets.only(bottom: 15),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Map<String, dynamic> data = {
                          "first name": fn,
                          "last name": ln
                        };
                        // cr.add(data);
                        final cr = FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .set(data);
                      },
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        final cr = FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .update({"first name": fn, "last name": ln});
                        /*
                        cr.snapshots().listen((snapshot) {
                          List documents;
                          setState(() {
                            documents = snapshot.docs;
                            print(documents);
                          });
                        });
                        */
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        final cr = FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .delete();
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        final cr =
                            FirebaseFirestore.instance.collection("user");
                        // .doc(FirebaseAuth.instance.currentUser?.uid);
                        // await cr.get().then((DocumentSnapshot snapshot) async {
                        //   setState(() {
                        //     name = snapshot.data;
                        //   });
                        // });
                        await cr.get().then((event) {
                          setState(() {
                          for (var doc in event.docs) {
                            name = name + doc.data().values.toList()[1] + " " + doc.data().values.toList()[0];
                          } 
                          });
                        });
                      },
                      child: Text(
                        "Read",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black)
                  // ),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            TextButton(
              onPressed: () {
                signOut()
                    .then((value) => Navigator.pushNamed(context, 'login'));
              },
              child: Text(
                "LOGOUT",
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
                onPressed: () async {
                  await user
                      ?.delete()
                      .then((value) => Navigator.pushNamed(context, "signup"));
                },
                child: Text("Delete User"))
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        child: wl.elementAt(ci),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ci,
        // type: BottomNavigationBarType.shifting,
        selectedFontSize: 15,
        unselectedFontSize: 12,
        // selectedItemColor: Colors.purple,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Start Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: "Main Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings Page",
          ),
        ],
        onTap: (value) {
          setState(() {
            ci = value;
          });
        },
      ),
    );
  }
}
