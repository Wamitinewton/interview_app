import 'package:flutter/material.dart';
import 'package:app_interview/mobx/random_recipes_url.dart';
import 'package:app_interview/data/database.dart';
import 'package:app_interview/models/favorite_model.dart';
import 'package:app_interview/models/info_model.dart';
import 'package:app_interview/screen/dummy/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailRecipeScreen extends StatefulWidget {
  const DetailRecipeScreen({super.key, required this.RecipeId});
  final String RecipeId;

  @override
  State<DetailRecipeScreen> createState() => _DetailRecipeScreenState();
}

class _DetailRecipeScreenState extends State<DetailRecipeScreen> {
  final data = dummyRecipe();

  late SharedPreferences _logindata;
  late String _email = '';
  bool _isFavorite = false;
  List<FavoriteRecipe> _favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      _email = _logindata.getString('email')!;
    });
    await _checkFavoriteStatus();  // Ensure this awaits the operation
  }

  Future<void> _checkFavoriteStatus() async {
    List<Map<String, dynamic>> favoriteList =
        await DatabaseHelper.instance.getListFavorite(_email);
    List<FavoriteRecipe> favoriteRecipes =
        favoriteList.map((map) => FavoriteRecipe.fromMap(map)).toList();

    setState(() {
      _favoriteRecipes = favoriteRecipes;
      _isFavorite =
          _favoriteRecipes.any((recipe) => recipe.recipeId == widget.RecipeId);
    });
    print('_isFavorite: $_isFavorite');
    print('_favoriteRecipes: $_favoriteRecipes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Recipe",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: FutureBuilder(
          future: ApiRandomRecipes.instance.informationRecipe(widget.RecipeId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("ADA ERROR");
            }
            if (snapshot.hasData && snapshot.data != null) {
              InfoRecipeModel recipe = InfoRecipeModel.fromJson(snapshot.data!);
              return ListView(
                children: [
                  Image.network(
                    recipe.image.toString(),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title.toString(),
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${recipe.nutrition?.nutrients![0].amount} Calories",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.deepOrange),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_outlined,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${recipe.readyInMinutes} mins",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: _isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  var mins = recipe.readyInMinutes;
                                  var serving = recipe.servings;
                                  var image = recipe.image;
                                  var title = recipe.title;
                                  var cal = recipe
                                      .nutrition?.nutrients![0].amount
                                      .toString();

                                  _toggleFavoriteStatus(
                                      image.toString(),
                                      title.toString(),
                                      mins.toString(),
                                      serving.toString(),
                                      cal.toString());
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Ingredients",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.room_service_outlined,
                                      color: Colors.deepOrange),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${data.recipeData["recipes"][0]["servings"]} servings",
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recipe.extendedIngredients?.length ?? 0,
                            itemBuilder: (context, index) {
                              final ingredient =
                                  recipe.extendedIngredients?[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box,
                                      color: Colors.deepOrange,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      ingredient?.original ?? '',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<void> _toggleFavoriteStatus(String image, String title, String ready,
      String serving, String cal) async {
    String message = '';
    late Color color;
    if (_isFavorite) {
      // Remove from favorites
      print('Removing from cart: $_email, ${widget.RecipeId}');
      await DatabaseHelper.instance
          .deleteFavorite(_email, widget.RecipeId, 'cart_recipes');
      message = 'Recipe removed from Cart';
      color = Colors.red;
    } else {
      // Add to favorites
      print(
          'Adding to cart: $_email, ${widget.RecipeId}, $image, $title, $ready, $serving, $cal');
      await DatabaseHelper.instance.insertCart(
        _email,
        widget.RecipeId,
        image,
        title,
        ready,
        serving,
        cal,
      );
      message = 'Recipe added to cart';
      color = Colors.green;
    }

    // Update favorite status
    await _checkFavoriteStatus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
    print(message);
  }
}
