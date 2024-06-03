// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecipeStore on _RecipeStore, Store {
  late final _$randomRecipesAtom =
      Atom(name: '_RecipeStore.randomRecipes', context: context);

  @override
  ObservableMap<String, dynamic> get randomRecipes {
    _$randomRecipesAtom.reportRead();
    return super.randomRecipes;
  }

  @override
  set randomRecipes(ObservableMap<String, dynamic> value) {
    _$randomRecipesAtom.reportWrite(value, super.randomRecipes, () {
      super.randomRecipes = value;
    });
  }

  late final _$suggestedRecipesAtom =
      Atom(name: '_RecipeStore.suggestedRecipes', context: context);

  @override
  ObservableMap<String, dynamic> get suggestedRecipes {
    _$suggestedRecipesAtom.reportRead();
    return super.suggestedRecipes;
  }

  @override
  set suggestedRecipes(ObservableMap<String, dynamic> value) {
    _$suggestedRecipesAtom.reportWrite(value, super.suggestedRecipes, () {
      super.suggestedRecipes = value;
    });
  }

  late final _$_RecipeStoreActionController =
      ActionController(name: '_RecipeStore', context: context);

  @override
  void setRandomRecipes(Map<String, dynamic> recipes) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.setRandomRecipes');
    try {
      return super.setRandomRecipes(recipes);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSuggestedRecipes(Map<String, dynamic> recipes) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.setSuggestedRecipes');
    try {
      return super.setSuggestedRecipes(recipes);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
randomRecipes: ${randomRecipes},
suggestedRecipes: ${suggestedRecipes}
    ''';
  }
}
