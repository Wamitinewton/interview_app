import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_interview/data/database.dart';
import 'package:app_interview/models/favorite_model.dart';
import 'package:app_interview/screen/detaill_recipe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dando/database_helper.dart'; // Sesuaikan dengan lokasi file DatabaseHelper.dart
// import 'package:your_app/models/favorite_recipe.dart'; // Sesuaikan dengan lokasi file FavoriteRecipe.dart

class CartScreenView extends StatefulWidget {
  const CartScreenView({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreenView> {
  late SharedPreferences _logindata;
  late String _email = '';
  List<FavoriteRecipe> _favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    _getLoginData();
  }

  Future<void> _getLoginData() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      _email = _logindata.getString('email')!;
    });
    _loadFavoriteRecipes();
  }

  Future<void> _loadFavoriteRecipes() async {
    List<Map<String, dynamic>> favoriteList =
        await DatabaseHelper.instance.getListFavorite(_email);
    List<FavoriteRecipe> favoriteRecipes =
        favoriteList.map((map) => FavoriteRecipe.fromMap(map)).toList();

    setState(() {
      _favoriteRecipes = favoriteRecipes;
    });
    print(favoriteList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onSelected: (value) {
              if (value == 'deleteAll') {
                DatabaseHelper.instance.deleteAllFavorites(_email);
                _loadFavoriteRecipes();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Recipe removed from Cart.'),
                    duration: Duration(seconds: 5),
                  ),
                );
                print("list : ${_favoriteRecipes}");
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'deleteAll',
                child: Text('Delete All Cart items'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: _favoriteRecipes.isEmpty
          ? const Center(
              child: Text('No recipes were found in the cart.'),
            )
          : ListView.builder(
              itemCount: _favoriteRecipes.length,
              itemBuilder: (context, index) {
                return _buildFavoriteRecipeCard(_favoriteRecipes[index]);
              },
            ),
    );
  }

  Widget _buildFavoriteRecipeCard(FavoriteRecipe cartRecipe) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailRecipeScreen(RecipeId: cartRecipe.recipeId)),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 240, 239, 239),
          ),
          height: 130,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 140.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(cartRecipe.image)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0)),
                  // color: Colors.redAccent,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: const EdgeInsets.only(top: 18),
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartRecipe.title,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          // softWrap: true,
                        ),
                        Text('${cartRecipe.calories} Calories',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrange,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule_outlined,
                              color: Colors.grey,
                              size: 13,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${cartRecipe.readyInMinutes} m',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            const Icon(
                              Icons.room_service_outlined,
                              color: Colors.grey,
                              size: 13,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${cartRecipe.servings} serv.',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.red,
                            size: 25,
                          ),
                          onPressed: () {
                            _showCheckOutDialog(cartRecipe);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _removeFavoriteRecipe(FavoriteRecipe favoriteRecipe) async {
    await DatabaseHelper.instance
        .deleteFavorite(_email, favoriteRecipe.recipeId, 'cart_recipes');
    _loadFavoriteRecipes();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recipe checked out successfully.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _showCheckOutDialog(FavoriteRecipe favoriteRecipe) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Checkout'),
            content: const Text('Do you want to check out the cart?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _removeFavoriteRecipe(favoriteRecipe);
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
