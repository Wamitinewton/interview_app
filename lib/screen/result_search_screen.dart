import 'package:flutter/material.dart';
import 'package:app_interview/mobx/random_recipes_url.dart';
import 'package:app_interview/models/search_data.dart';
import 'package:app_interview/screen/detaill_recipe_screen.dart';
import 'package:app_interview/screen/dummy/dummy_data.dart';

class ResultSearchScreen extends StatefulWidget {
  const ResultSearchScreen({super.key, required this.query});
  final String query;
  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  final data = dummyRecipe();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("search result",
                  style: TextStyle(color: Colors.black, fontSize: 13)),
              Text(" ${widget.query.toUpperCase()}",
                  style: const TextStyle(color: Colors.lightGreen)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: ApiRandomRecipes.instance.searchRecipe(widget.query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("ADA ERROR");
          }
          if (snapshot.hasData && snapshot.data != null) {
            ResultSearchModel result =
                ResultSearchModel.fromJson(snapshot.data!);
            return buildResultScreen(result: result);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class buildResultScreen extends StatelessWidget {
  const buildResultScreen({super.key, required this.result});
  final ResultSearchModel result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: result.results!.length,
            itemBuilder: (BuildContext context, int index) {
              var data = result.results![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailRecipeScreen(
                              RecipeId: data.id.toString())));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            data.image.toString(),
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title.toString(),
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                                // overflow: TextOverflow.ellipsis,
                                // maxLines: 1,
                                softWrap: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Tap to see detail recipe",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// FutureBuilder(
//                 future: ApiRandomRecipes.instance
//                     .informationRecipe(data.id!.toString()),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text("ADA ERROR");
//                   }
//                   if (snapshot.hasData && snapshot.data != null) {
//                     InfoRecipeModel recipe =
//                         InfoRecipeModel.fromJson(snapshot.data!);
//                     return Expanded(
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 5,
//                 crossAxisSpacing: 5,
//                 childAspectRatio: 0.8),
//             itemCount: result.results!.length,
//             itemBuilder: (context, index) {
//               var data = result.results![index];

//               return ;
//             },
//           ),
//         );
//                   }
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),


// Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       padding: EdgeInsets.all(15),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           //Recipe Image
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image.network(
//                               // data.recipeData["recipes"][0]["image"].toString(),
//                               recipe.image.toString(),
//                               height: 130,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),

//                           //Recipe Title
//                           Text(
//                             // data.recipeData["recipes"][0]["title"].toString(),
//                             recipe.title.toString(),
//                             style: TextStyle(
//                               fontSize: 19,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),

//                           //Recipe Calories

//                           // FutureBuilder(
//                           //   future:
//                           //       ApiRandomRecipes.instance.informationRecipe("660504"),
//                           //   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                           //     if (snapshot.hasData && snapshot.data != null) {
//                           //       InfoRecipeModel dataInfo =
//                           //           InfoRecipeModel.fromJson(snapshot.data!);
//                           //       return Text(
//                           //           " ${dataInfo.nutrition!.nutrients![0].amount} Calories",
//                           //           style: TextStyle(color: Colors.deepOrange));
//                           //     }
//                           //     return Text(
//                           //       "Calories",
//                           //       style: TextStyle(color: Colors.deepOrange),
//                           //     );
//                           //   },
//                           // ),
//                           Text(
//                             " ${recipe.nutrition!.nutrients![0].amount} Calories",
//                             style: TextStyle(color: Colors.deepOrange),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),

//                           //Recipe Info
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.schedule_outlined,
//                                     color: Colors.grey,
//                                     size: 15,
//                                   ),
//                                   SizedBox(
//                                     width: 8,
//                                   ),
//                                   Text(
//                                     // "${data.recipeData["recipes"][0]["readyInMinutes"]} mins",
//                                     recipe.readyInMinutes.toString(),
//                                     style: TextStyle(color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.room_service_outlined,
//                                     color: Colors.grey,
//                                     size: 15,
//                                   ),
//                                   SizedBox(
//                                     width: 8,
//                                   ),
//                                   Text(
//                                     // "${data.recipeData["recipes"][0]["servings"]} servings",
//                                     recipe.servings.toString(),
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );