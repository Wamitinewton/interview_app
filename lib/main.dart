import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:app_interview/mobx/api_suggestion_recipes.dart';
import 'package:app_interview/hive/cached_data.dart';
import 'package:app_interview/mobx/recipe_store.dart';
import 'package:app_interview/screen/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CachedDataAdapter());
  await Hive.openBox<CachedData>('cacheBox');
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDSjL7-NqizRuTIYU2zqUpMCddVEgyiBp0",
          appId: "1:862069428665:android:f80bd34595170d566b6668",
          messagingSenderId: "862069428665",
          projectId: "interviewapp-f6657",
          storageBucket: "interviewapp-f6657.appspot.com"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RecipeStore _recipeStore = RecipeStore();
  final ApiSuggestionRecipes _apiSuggestionRecipes = ApiSuggestionRecipes();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecipeStore>(create: (_) => _recipeStore),
        Provider<ApiSuggestionRecipes>(create: (_) => _apiSuggestionRecipes),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        title: 'Flutter Demo',
        home: const WelcomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
