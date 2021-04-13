import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function onLogin;
  LoginScreen({this.onLogin});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController textController = TextEditingController();

  void attemptLogin() {
    if (textController.text.isNotEmpty) {
      widget.onLogin();
    } 
  }

  String validationText() {
    if (textController.text.isNotEmpty) {
      return 'Please input a username';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      children: [
        TextField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
            errorText: validationText()
          ),
        ), 
        ElevatedButton(
          onPressed: attemptLogin,
          child: Text('Start!'),)
      ],
    );
  }
}