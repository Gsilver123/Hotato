import 'package:flutter/material.dart';
import 'imageFling.dart';
import 'loginScreen.dart';
import 'apiService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotato App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      home: MyHomePage(titleAssest: 'assets/images/logo.png',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.titleAssest}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String titleAssest;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ApiService apiService = ApiService();

  bool hasFlicked = false;
  bool hasLoggedIn = false;
  bool noPotato = false;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var size = MediaQuery.of(context).size;

    Widget loginPage = LoginScreen(onLogin: (username) { 
      requestNewUser(username);
    },);

    Widget imageFling = ImageFling(onComplete: onComplete);

    Widget youFlicked = Container(
      alignment: Alignment.center,
      child: Image.asset('assets/images/safe/safe.png'),
    );

    Widget spinningPotato = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(flex: 5, child: Container(alignment: AlignmentDirectional.bottomCenter, child: imageFling)),
        Flexible(flex: 4, child: Container(alignment: AlignmentDirectional.center, child: Image.asset('assets/images/firepit/1.firepit-middle.png',)))
      ]
    );

    Widget youreSafe = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(flex: 5, child: Container(alignment: AlignmentDirectional.bottomCenter, child: youFlicked)),
        Flexible(flex: 4, child: Container(alignment: AlignmentDirectional.center, child: Image.asset('assets/images/firepit/1.firepit-start.png',)))
      ]
    );

    Image headerImage = Image.asset(widget.titleAssest);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: headerImage,
      ),
      body: hasLoggedIn ? (hasFlicked ? youreSafe : spinningPotato) : loginPage,
      floatingActionButton: FloatingActionButton(
        onPressed: onComplete,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void onComplete() {
    setState(() {
      hasFlicked = true;
    });
  }

  void requestNewUser(String username) {
    apiService.postInitialUser(username, (isLoggedIn) {
      if (isLoggedIn) { 
        setState(() { hasLoggedIn = true; });  
      }
    });
  }
}
