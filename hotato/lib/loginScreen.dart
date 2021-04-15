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
                hintText: 'First name & Last initial'
              ),
            )
          )
        ), 
        Image.asset('assets/images/logo.png'),
        ClipOval(
          child: Material(
            color: Colors.red[400],
            child: InkWell(
              splashColor: Colors.red, // inkwell color
              child: SizedBox(width: 115,
                height: 115, 
                child: Align(
                  alignment: AlignmentDirectional.center, 
                  child:Text('Play!', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
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