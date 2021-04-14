import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MySharedPreferences {
  void isFirstLoad(Function(bool, String) callback) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasLoaded = prefs.getBool('has_loaded') ?? false;
    if (!hasLoaded) {
      prefs.setBool('has_loaded', true);
      prefs.setString('uuid', createUUID());
    }

    callback(hasLoaded, prefs.getString('uuid'));
  }

  String createUUID() {
    var uuid = Uuid();
    return uuid.v1();
  }
}