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
    var size = MediaQuery.of(context).size;

    return Column (
      children: [
        Image.asset('assets/images/logo.png'),
        Form(
          key: form,
          child: SizedBox(
            width: size.width * .8,
            child: TextFormField(
              controller: textController,
              validator: (text) {
                return validationText(text);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: 'Input Username'
              ),
            )
          )
        ), 
        ClipOval(
          child: Material(
            color: Colors.blue,
            child: InkWell(
              splashColor: Colors.red, // inkwell color
              child: SizedBox(width: 75,
                height: 75, 
                child: Align(
                  alignment: AlignmentDirectional.center, 
                  child:Text('Start!', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
                    )
                  )
                ),
              onTap: () { attemptLogin(); },
            ),
          )
        )
      ],
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}