import 'package:flutter/material.dart';
import 'package:app_interview/screen/dummy/dummy_data.dart';

class dummyCategoryScreen extends StatefulWidget {
  const dummyCategoryScreen(
      {super.key, required this.categoryName, required this.tags});
  final String categoryName;
  final String tags;

  @override
  State<dummyCategoryScreen> createState() => _dummyCategoryScreenState();
}

class _dummyCategoryScreenState extends State<dummyCategoryScreen> {
  final data = dummyRecipe();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.categoryName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.85,
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      data.recipeData["recipes"][0]["image"].toString(),
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    data.recipeData["recipes"][0]["title"].toString(),
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
                          const Icon(
                            Icons.access_time_outlined,
                            size: 18,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            data.recipeData["recipes"][0]["readyInMinutes"]
                                    .toString() +
                                " mins",
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
            );
          },
        ),
      ),
    );
    // _buildHomeScreen(recipes: recipes);
  }
}
