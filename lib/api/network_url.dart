import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:app_interview/hive/cached_data.dart';

class BaseNetwork {
  static const String baseUrl = "https://api.spoonacular.com";
  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = "$baseUrl/$partUrl";
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    var cacheBox = Hive.box<CachedData>('cacheBox');
    var cacheKey = fullUrl;
    // check if the data is in the cache
    if (cacheBox.containsKey(cacheKey)) {
      debugPrint('loading from cache');
      final cachedData = cacheBox.get(cacheKey)!.data;
      return json.decode(cachedData);
    }
    // if not in cache, fetch from network
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");

    if (response.statusCode == 200) {
      final body = response.body;
      if (body.isNotEmpty) {
        // cache the response to local db
        var cachedData = CachedData()..data = body;
        cacheBox.put(cacheKey, cachedData);
        final jsonBody = json.decode(body);
        return jsonBody;
      } else {
        debugPrint('Response body is empty');
        return {"Error": true};
      }
    } else {
      debugPrint('HTTP error: ${response.statusCode}');
      return {"Error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
