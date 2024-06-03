import 'package:flutter/material.dart';
import 'package:app_interview/mobx/api_suggestion_recipes.dart';
import 'package:app_interview/models/suggestion_data.dart';
import 'package:app_interview/screen/detaill_recipe_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AllSuggestionScreen extends StatefulWidget {
  const AllSuggestionScreen(
      {super.key, required this.minCal, required this.maxCal});
  final String minCal;
  final String maxCal;

  @override
  State<AllSuggestionScreen> createState() => _AllSuggestionScreenState();
}

class _AllSuggestionScreenState extends State<AllSuggestionScreen> {
  final ApiSuggestionRecipes apiSuggestionRecipes = ApiSuggestionRecipes();

  @override
  void initState() {
    super.initState();
    apiSuggestionRecipes.allSuggestionResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("Suggestions Recipes",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[200],
        body: Observer(
          builder: (_) {
            if (apiSuggestionRecipes.allSuggestionResults.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (apiSuggestionRecipes.allSuggestionResults['error'] == true) {
              return const Center(
                child: Text('ADA ERROR'),
              );
            }
            List<Map<String, dynamic>> listRecipes = List.from(
                apiSuggestionRecipes.allSuggestionResults['results'] ?? []);

            List<SuggestionRecipesModel> recipes = listRecipes
                .map(
                    (jsonRecipe) => SuggestionRecipesModel.fromJson(jsonRecipe))
                .toList();
            return _buildHomeScreen(recipes: recipes);
          },
        ));
  }
}

class _buildHomeScreen extends StatelessWidget {
  const _buildHomeScreen({super.key, required this.recipes});
  final List<SuggestionRecipesModel> recipes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.85,
      ),
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        var recipe = recipes[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailRecipeScreen(RecipeId: recipe!.id.toString())));
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    recipe!.image.toString(),
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  recipe.title.toString(),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          recipe.calories.toString() + " kcal",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey[400],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
