import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hive/hive.dart';

class ApiSuggestionRecipes {
  static ApiSuggestionRecipes instance = ApiSuggestionRecipes();

  Future<List<dynamic>> searchSuggestionRecipe(String minCal, String maxCal) {
    return Api.get(
        "/recipes/findByNutrients?apiKey=640bdad4d27043728a5168e8c4820363&minCalories=$minCal&maxCalories=$maxCal&number=10");
  }

  Future<List<dynamic>> allSuggestionRecipe(String minCal, String maxCal) {
    return Api.get(
        "/recipes/findByNutrients?apiKey=640bdad4d27043728a5168e8c4820363&minCalories=$minCal&maxCalories=$maxCal&number=20");
  }
}

class Api {
  static const String baseUrl = "https://api.spoonacular.com";

  static Future<List<dynamic>> get(String partUrl) async {
    final String fullUrl = "$baseUrl/$partUrl";
    debugPrint("BaseNetwork - fullUrl: $fullUrl");

    var cacheBox = Hive.box<String>('cacheBox');

    // Check if data is in the cache
    if (cacheBox.containsKey(fullUrl)) {
      debugPrint("Loading from cache");
      final cachedData = cacheBox.get(fullUrl)!;
      return json.decode(cachedData);
    }

    // If not in cache, fetch from network
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response: ${response.body}");

    if (response.statusCode == 200) {
      final body = response.body;
      if (body.isNotEmpty) {
        // Cache the response
        cacheBox.put(fullUrl, body);
        final jsonBody = json.decode(body);
        return jsonBody;
      } else {
        debugPrint("Response body is empty");
        return [];
      }
    } else {
      debugPrint("HTTP error: ${response.statusCode}");
      return [];
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
