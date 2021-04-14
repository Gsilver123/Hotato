import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function onLogin;
  LoginScreen({this.onLogin});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController textController = TextEditingController();
  final form = GlobalKey<FormState>();

  void attemptLogin() {
    final isValid = form.currentState.validate();
    if (isValid) {
      widget.onLogin(textController.text);
    } 
  }

  String validationText(String text) {
    if (text.isEmpty) {
      return 'Please input a username';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      children: [
        Form(
          key: form,
          child: TextFormField(
            controller: textController,
            validator: (text) {
              return validationText(text);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input Username'
            ),
          )
        ), 
        ElevatedButton(
          onPressed: attemptLogin,
          child: Text('Start!'),)
      ],
    );
  }
}