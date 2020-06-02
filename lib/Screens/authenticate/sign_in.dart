import 'package:dbms/services/auth.dart';
import 'package:dbms/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0
        ),
//child: RaisedButton(
//  child: Text('Sign in anon'),
//  onPressed: () async {
//    dynamic result = await _auth.signInAnon();
//    if(result == null)
//      {
//        print('error signing in');
//      }
//    else
//      {
//        print("Signed in\n");
//        print(result.uid);
//      }
//}
//),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0)
                ),
              ),
              validator: (val) => val.isEmpty ? "Enter an email" : null,
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0)
                ),
              ),
              validator: (val) =>
              val.length < 6
                  ? "Enter a password 6 characters long"
                  : null,
              obscureText: true,
              onChanged: (val) {
                password = val;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                setState(() => loading = true);
                if (_formkey.currentState.validate()) {
                  dynamic result = _auth.signInWithEmailAndPassword(
                      email, password);
                  print('valid');
                  if (result == null) {
                    setState(() {
                      error = 'Please enter correct credentials';
                      loading = false;
                    });
                  }
                }
              },

            ),
            SizedBox(height: 12.0),
            Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),)
          ],
        ),
      ),
      ),
    );
  }
}
