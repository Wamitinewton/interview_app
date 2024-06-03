import 'package:app_interview/api/network_url.dart';
import 'package:app_interview/mobx/recipe_store.dart';


class ApiRandomRecipes {
  static ApiRandomRecipes instance = ApiRandomRecipes();

  final RecipeStore _recipeStore = RecipeStore();

  Future<Map<String, dynamic>> loadRandomRecipes() async {
    try {
      final result = await BaseNetwork.get(
         "recipes/random?apiKey=640bdad4d27043728a5168e8c4820363&number=5"
      );
      _recipeStore.setRandomRecipes(result);
      return result;
    } catch (e) {
      print('Error loading random recipes: $e');
      return{};
    }
  }

   Future<Map<String, dynamic>> categoryRecipes(String categoryName) async {
    try {
      String category = categoryName.toString();
      final result = await BaseNetwork.get(
          "recipes/random?apiKey=640bdad4d27043728a5168e8c4820363&number=10&tags=$category");
      _recipeStore.setSuggestedRecipes(result);
      return result;
    } catch (e) {
      print("Error loading category recipes: $e");
      return {};
    }
  }

  
  Future<Map<String, dynamic>> informationRecipe(String idRecipe) {
    String id = idRecipe.toString();
    return BaseNetwork.get(
        "/recipes/$id/information?apiKey=640bdad4d27043728a5168e8c4820363&includeNutrition=true");
  }

  Future<Map<String, dynamic>> searchRecipe(String query) {
    return BaseNetwork.get(
        "/recipes/complexSearch?apiKey=640bdad4d27043728a5168e8c4820363&query=$query&number=10");
  }


  // Future<Map<String, dynamic>> loadRandomRecipes() {
  //   return BaseNetwork.get(
  //       "recipes/random?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&number=5");
  // }

  // Future<Map<String, dynamic>> categoryRecipes(String categoryName) {
  //   String category = categoryName.toString();
  //   return BaseNetwork.get(
  //       "recipes/random?apiKey=0dd4eb84a40745b9a88fcf7361d5683d&number=10&tags=$category");
  // }

}
