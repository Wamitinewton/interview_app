import 'package:flutter/material.dart';
import 'package:app_interview/data/database.dart';
import 'package:app_interview/models/favorite_model.dart';
import 'package:app_interview/screen/dummy/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dummyDetailRecipeScreen extends StatefulWidget {
  const dummyDetailRecipeScreen({super.key, required this.RecipeId});
  final String RecipeId;

  @override
  State<dummyDetailRecipeScreen> createState() =>
      _dummyDetailRecipeScreenState();
}

class _dummyDetailRecipeScreenState extends State<dummyDetailRecipeScreen> {
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
    _checkFavoriteStatus();
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
      // favoriteRecipes.any((element) => element['recipeId'] == widget.RecipeId);
    });
    print(_isFavorite);
    print(_favoriteRecipes);
  }

  Future<void> _toggleFavoriteStatus() async {
    String message = '';
    late Color color;
    if (_isFavorite) {
      // Hapus dari daftar favorit
      await DatabaseHelper.instance
          .deleteFavorite(_email, widget.RecipeId, 'cart_recipes');
      message = 'Recipe removed from cart';
      color = Colors.red;
    } else {
      // Tambahkan ke daftar favorit
      await DatabaseHelper.instance.insertCart(
        _email,
        widget.RecipeId,
        data.recipeData["recipes"][0]["image"].toString(),
        data.recipeData["recipes"][0]["title"].toString(),
        data.recipeData["recipes"][0]["readyInMinutes"].toString(),
        data.recipeData["recipes"][0]["servings"].toString(),
        "300",
      );
      message = 'Recipe added to favorite';
      color = Colors.green;
    }

    // Perbarui status favorit
    _checkFavoriteStatus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
    print(message);
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
      body: ListView(
        children: [
          Image.network(
            data.recipeData["recipes"][0]["image"].toString(),
            // fit: BoxFit.cover,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.recipeData["recipes"][0]["title"].toString(),
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
                        const Text(
                          "Calories",
                          style:
                              TextStyle(fontSize: 20, color: Colors.deepOrange),
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
                              "${data.recipeData["recipes"][0]["readyInMinutes"]} mins",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // Icon(
                            //   Icons.room_service_outlined,
                            //   size: 20,
                            //   color: Colors.grey,
                            // ),
                            // Text(
                            //   "${data.recipeData["recipes"][0]["servings"]} servings",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        icon: _isFavorite
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite_border_outlined),
                        onPressed: () {
                          _toggleFavoriteStatus();
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.chevron_right,
                                color: Colors.deepOrange[200],
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["nameClean"]}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["amount"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["unit"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.chevron_right,
                                color: Colors.deepOrange[200],
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["nameClean"]}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["amount"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["unit"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.chevron_right,
                                color: Colors.deepOrange[200],
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["nameClean"]}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["amount"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["unit"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.chevron_right,
                                color: Colors.deepOrange[200],
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["nameClean"]}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["amount"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${data.recipeData["recipes"][0]["extendedIngredients"][0]["unit"]}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Instructions",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${data.recipeData["recipes"][0]["analyzedInstructions"][0]["steps"][0]["step"]}",
                          style: const TextStyle(fontSize: 16.0, color: Colors.black),
                        )
                        // ]
                        // List.generate(
                        //   4,
                        //   (index) => Text(
                        //     "${index + 1}. ${data.recipeData["recipes"][0]["analyzedInstructions"][0]["steps"][index]["step"]}",
                        //     style: TextStyle(fontSize: 16.0),
                        //   ),
                        // ),
                        // ),
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[50],
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${data.recipeData["recipes"][0]["analyzedInstructions"][0]["steps"][1]["step"]}",
                          style: const TextStyle(fontSize: 16.0),
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[50],
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${data.recipeData["recipes"][0]["analyzedInstructions"][0]["steps"][2]["step"]}",
                          style: const TextStyle(fontSize: 16.0),
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[50],
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${data.recipeData["recipes"][0]["analyzedInstructions"][0]["steps"][3]["step"]}",
                          style: const TextStyle(fontSize: 16.0),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
