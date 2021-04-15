import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  void postInitialUser(String username, String uuid, Function(bool) callback) async {
    final response = await http.post(Uri.https('qz1wuu0nif.execute-api.us-east-1.amazonaws.com', 'beta'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'key': uuid,
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

  void updateUserGameState(bool hasLived, String uuid) async {
    final response = await http.post(Uri.https('0qw812c8w8.execute-api.us-east-1.amazonaws.com', 'alpha'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'key': uuid,
        'state': hasLived ? 1 : 0,
        'time': DateTime.now().millisecondsSinceEpoch / 1000
      }),
    );

    if (response.statusCode == 200) {
      print('updated'); 
    } else {
      print(response.statusCode);
    }
  } 

  void getInitialState(String uuid, Function(int, int) callback) async {
    final response = await http.post(Uri.https('4pt18y20i9.execute-api.us-east-1.amazonaws.com', 'alpha'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'key': uuid
      }),
    );

    if (response.statusCode == 200) {
      print('Retrieved Initial State');
      var decoded = json.decode(response.body.toString());
      print('State: ' + json.decode(decoded['body'].toString())['state'].toString());
      callback(json.decode(decoded['body'].toString())['state'], json.decode(decoded['body'].toString())['has_potato']);
    } else {
      print(response.statusCode);
      callback(0, 0);
    }
  }

  void startGame() async {
    final response = await http.post(Uri.https('i7zrveu7uf.execute-api.us-east-1.amazonaws.com', 'alpha'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        
      }),
    );

    if (response.statusCode == 200) {
      print('yay!');
    } else {
      print('Noo');
    }
  }
}