import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_interview/mobx/api_suggestion_recipes.dart';
import 'package:app_interview/models/suggestion_data.dart';
import 'package:app_interview/screen/all_suggestion_screen.dart';
import 'package:app_interview/screen/detaill_recipe_screen.dart';
import 'package:app_interview/screen/dummy/dummy_data.dart';

class ResultCalciTrackScreen extends StatefulWidget {
  const ResultCalciTrackScreen({
    super.key,
    required this.bmiResult,
    required this.bmiText,
    required this.bmiAdvise,
    required this.bmiTextColor,
    required this.bmrResult,
    required this.mincaloriePerMeal,
    required this.maxcaloriePerMeal,
  });
  final String bmiResult;
  final String bmiText;
  final String bmiAdvise;
  final Color bmiTextColor;
  final String bmrResult;
  final String mincaloriePerMeal;
  final String maxcaloriePerMeal;

  @override
  State<ResultCalciTrackScreen> createState() => _ResultCalciTrackScreenState();
}

class _ResultCalciTrackScreenState extends State<ResultCalciTrackScreen> {
  final data = dummyRecipe();
  final ApiSuggestionRecipes apiSuggestionRecipes = ApiSuggestionRecipes();

  @override
  void initState() {
    super.initState();
    
    apiSuggestionRecipes.searchSuggestionRecipe(
        widget.mincaloriePerMeal, widget.maxcaloriePerMeal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //BMI Result
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "BMI Result",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.bmiText,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: widget.bmiTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.bmiResult,
                        style: const TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //BMI Advise
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    widget.bmiAdvise,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                //BMR Result
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "BMR Result",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Calories",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: widget.bmiTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.bmrResult,
                            style: const TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "kcal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //Calorie per meal
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "Based on your BMI, you need to consume at least ",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      TextSpan(
                          text:
                              "${widget.mincaloriePerMeal} - ${widget.maxcaloriePerMeal}",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      TextSpan(
                        text: " calories per meal to get your ideal weight",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                //Recipes Suggestion
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recipes Suggestion",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllSuggestionScreen(
                                      minCal: widget.mincaloriePerMeal,
                                      maxCal: widget.maxcaloriePerMeal,
                                    )));
                      },
                      child: const Row(
                        children: [
                          Text(
                            "See All",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
                          ),
                          Icon(
                            Icons.keyboard_double_arrow_right_rounded,
                            color: Colors.deepOrange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                //Popular Recipes Cards
                Observer(builder: (context) {
                  if (apiSuggestionRecipes.searchSuggestionResults.isEmpty) {
                    return const Text("Empty");
                  }
                  if (apiSuggestionRecipes.searchSuggestionResults['Error'] ==
                      true) {
                    return const Text('ADA ERROR');
                  }
                  List<Map<String, dynamic>> searchRecipes = List.from(
                      apiSuggestionRecipes.searchSuggestionResults['results'] ??
                          []);

                  List<SuggestionRecipesModel> recipes = searchRecipes
                      .map((jsonRecipe) =>
                          SuggestionRecipesModel.fromJson(jsonRecipe))
                      .toList();

                  return buildCardRecipe(recipes: recipes);
                })
              ],
            ),
          ),
        ));
  }
}

class buildCardRecipe extends StatelessWidget {
  const buildCardRecipe({super.key, required this.recipes});
  final List<SuggestionRecipesModel> recipes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            var recipe = recipes[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailRecipeScreen(
                            RecipeId: recipe.id.toString())));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                padding: const EdgeInsets.all(15),
                width: 220,
                margin: const EdgeInsets.only(right: 15),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Recipe Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          recipe.image.toString(),
                          height: 135,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Recipe Title
                      Text(
                        recipe.title.toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      //Recipe Calories
                      Text("${recipe.calories} Calories",
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18,
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
