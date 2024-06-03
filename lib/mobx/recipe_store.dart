import 'package:mobx/mobx.dart';

part 'recipe_store.g.dart';

class RecipeStore = _RecipeStore with _$RecipeStore;

abstract class _RecipeStore with Store {
  @observable
  ObservableMap<String, dynamic> randomRecipes = ObservableMap();

  @observable
  ObservableMap<String, dynamic> suggestedRecipes = ObservableMap();

  @action
  void setRandomRecipes(Map<String, dynamic> recipes) {
    randomRecipes.clear();
    randomRecipes.addAll(recipes);
  }

  @action
  void setSuggestedRecipes(Map<String, dynamic> recipes) {
    suggestedRecipes.clear();
    suggestedRecipes.addAll(recipes);
  }
}
