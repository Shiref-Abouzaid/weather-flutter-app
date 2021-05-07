import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response res = await http.get(Uri.parse(url));
    print(res.statusCode);
    if(res.statusCode == 200) {

      String data = res.body;
      var decodedData = jsonDecode(data);
      print(data);
      return decodedData;



    } else {
      print(res.statusCode);
    }
  }
}