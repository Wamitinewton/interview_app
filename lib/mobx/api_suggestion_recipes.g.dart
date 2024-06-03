// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_suggestion_recipes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ApiSuggestionRecipes on _ApiSuggestionRecipes, Store {
  late final _$searchSuggestionResultsAtom = Atom(
      name: '_ApiSuggestionRecipes.searchSuggestionResults', context: context);

  @override
  ObservableMap<String, dynamic> get searchSuggestionResults {
    _$searchSuggestionResultsAtom.reportRead();
    return super.searchSuggestionResults;
  }

  @override
  set searchSuggestionResults(ObservableMap<String, dynamic> value) {
    _$searchSuggestionResultsAtom
        .reportWrite(value, super.searchSuggestionResults, () {
      super.searchSuggestionResults = value;
    });
  }

  late final _$allSuggestionResultsAtom = Atom(
      name: '_ApiSuggestionRecipes.allSuggestionResults', context: context);

  @override
  ObservableMap<String, dynamic> get allSuggestionResults {
    _$allSuggestionResultsAtom.reportRead();
    return super.allSuggestionResults;
  }

  @override
  set allSuggestionResults(ObservableMap<String, dynamic> value) {
    _$allSuggestionResultsAtom.reportWrite(value, super.allSuggestionResults,
        () {
      super.allSuggestionResults = value;
    });
  }

  late final _$searchSuggestionRecipeAsyncAction = AsyncAction(
      '_ApiSuggestionRecipes.searchSuggestionRecipe',
      context: context);

  @override
  Future<void> searchSuggestionRecipe(String minCal, String maxCal) {
    return _$searchSuggestionRecipeAsyncAction
        .run(() => super.searchSuggestionRecipe(minCal, maxCal));
  }

  late final _$allSuggestionRecipeAsyncAction = AsyncAction(
      '_ApiSuggestionRecipes.allSuggestionRecipe',
      context: context);

  @override
  Future<void> allSuggestionRecipe(String minCal, String maxCal) {
    return _$allSuggestionRecipeAsyncAction
        .run(() => super.allSuggestionRecipe(minCal, maxCal));
  }

  @override
  String toString() {
    return '''
searchSuggestionResults: ${searchSuggestionResults},
allSuggestionResults: ${allSuggestionResults}
    ''';
  }
}
