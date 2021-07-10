import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  Network({this.url});
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}
