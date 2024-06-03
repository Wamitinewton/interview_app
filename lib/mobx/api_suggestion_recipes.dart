// api_suggestion_recipes.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';

part 'api_suggestion_recipes.g.dart';

class ApiSuggestionRecipes = _ApiSuggestionRecipes with _$ApiSuggestionRecipes;

abstract class _ApiSuggestionRecipes with Store {
  @observable
  ObservableMap<String, dynamic> searchSuggestionResults = ObservableMap();

  @observable
  ObservableMap<String, dynamic> allSuggestionResults = ObservableMap();

  @action
  Future<void> searchSuggestionRecipe(String minCal, String maxCal) async {
    try {
      final result = await Api.get(
          "/recipes/findByNutrients?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&minCalories=$minCal&maxCalories=$maxCal&number=10");
      searchSuggestionResults.clear();
      searchSuggestionResults.addAll(result);
    } catch (e) {
      debugPrint("Error fetching search suggestion recipes: $e");
    }
  }

  @action
  Future<void> allSuggestionRecipe(String minCal, String maxCal) async {
    try {
      final result = await Api.get(
          "/recipes/findByNutrients?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&minCalories=$minCal&maxCalories=$maxCal&number=20");
      allSuggestionResults.clear();
      allSuggestionResults.addAll(result);
    } catch (e) {
      debugPrint("Error fetching all suggestion recipes: $e");
    }
  }
}

class Api {
  static const String baseUrl = "https://api.spoonacular.com";

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = "$baseUrl/$partUrl";
    debugPrint("Api - fullUrl: $fullUrl");

    var cacheBox = Hive.box<String>('cacheBox');

    // Check if data is in the cache
    if (cacheBox.containsKey(fullUrl)) {
      debugPrint("Loading from cache");
      final cachedData = cacheBox.get(fullUrl)!;
      return json.decode(cachedData);
    }

    // If not in cache, fetch from network
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("Api - response: ${response.body}");

    if (response.statusCode == 200) {
      final body = response.body;
      if (body.isNotEmpty) {
        // Cache the response
        cacheBox.put(fullUrl, body);
        final jsonBody = json.decode(body);
        return jsonBody;
      } else {
        debugPrint("Response body is empty");
        return {};
      }
    } else {
      debugPrint("HTTP error: ${response.statusCode}");
      return {};
    }
  }

  static void debugPrint(String value) {
    print("[API] - $value");
  }
}
