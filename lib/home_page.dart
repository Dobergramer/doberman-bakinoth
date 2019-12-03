import 'package:doberman/firebase_auth_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  AuthFunc auth;
  VoidCallback onSignOut;
  String userId, userEmail;


  HomePage ({Key key,this.auth, this.onSignOut, this.userId, this.userEmail, onSignedOut}) : super (key:key);



  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isEmailVerified = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkEmailVerification();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Signed In'),
        actions: <Widget>[
          FlatButton(child: Text('oof'),onPressed: _signOut),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Center(
            child: Text('Hello '+widget.userEmail),
          ),
          new Center(
            child: Text(''),
          )
        ],
      ),
    );
  }


  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified)
      showVerifyEmailDialog();
  }

  void showVerifyEmailDialog() {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Please verify your email'),
            content: new Text('Verification is needed to continue this app'),
            actions: <Widget>[
              new FlatButton(onPressed: () {
                Navigator.of(context).pop();
                _sendVerifyEmail();
              }, child: Text('Send')),
              new FlatButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text('Dismiss'))
            ],
          );
        });
  }

  void _sendVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailSentDialog() {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Thank You'),
            content: new Text('Verification link has been sent to your email'),
            actions: <Widget>[
              new FlatButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text('OK'))
            ],
          );
        });

  }

  void _signOut() async {
    try{
      await widget.auth.signOut();
      widget.onSignOut(); //call back
    }catch(e) {
      print(e);
    }
  }
}




































