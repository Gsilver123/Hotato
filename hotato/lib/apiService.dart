import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  void postInitialUser(String username, Function(bool) callback) async {
    final response = await http.post(Uri.https('qz1wuu0nif.execute-api.us-east-1.amazonaws.com', 'alpha'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      print('completed'); 
    } else {
      print(response.statusCode);
    }

    callback(response.statusCode == 200);
  }
}