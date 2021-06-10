import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatPage',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ChatVibes"),backgroundColor: Colors.blue),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.blue[100],
            // Set a border for each side of the box
            border: Border(
                top: BorderSide(width:240, color: Colors.white70),
                right: BorderSide(width: 60, color: Colors.blue[200]),
                bottom: BorderSide(width: 240, color: Colors.white70),
                left: BorderSide(width: 60, color: Colors.blue[200])
            ),
        ),
        width: double.infinity,
        height: 850,
        alignment: Alignment.center,

        child: _isLoggedIn ?
        Column(

          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            Image.network(_userObj.photoUrl),
            Text(_userObj.displayName),
            Text(_userObj.email),
            TextButton.icon(
              icon: Icon(Icons.logout),

                onPressed: () {
                  _googleSignIn.signOut().then((value) {
                    setState(() {
                      _isLoggedIn = false;
                    });
                  }).catchError((e) {});
                },
                label: Text("Logout"),)
          ],
        )
            : Center(
          child: OutlineButton.icon(
            icon: Icon(Icons.account_circle),
            label: Text("Login with Google"),

            onPressed: () {
              _googleSignIn.signIn().then((userData) {
                setState(() {
                  _isLoggedIn = true;
                  _userObj = userData;
                });
              }).catchError((e) {
                print(e);
              });
            },
          ),
        ),
      ),
    );
  }
}