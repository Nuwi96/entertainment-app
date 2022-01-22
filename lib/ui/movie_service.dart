import 'dart:convert';
import 'package:http/http.dart' as http;



popularTvShows() async {
  http.Response response = await http.get('https://api.themoviedb.org/3/tv/popular?api_key=66ed895e7cd5320bdb1a8245e2a25f6a&language=en-US&page=1');
  if (response.statusCode != 200) return null;

  final items = jsonDecode(response.body);
  return items;
  // CityModel cityModel = CityModel.fromJson(json.decode(response.body));
  //
  // print('City Model:--> ${cityModel.list.elementAt(0).name}');
  // return CityModel.fromJson(items);
}