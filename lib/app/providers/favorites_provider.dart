import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/app/models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>>{
  FavoritesNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal){
    bool isFavorite = state.contains(meal);
    if(isFavorite){
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }else{
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoritesNotifier,List<Meal>>((ref) {
  return FavoritesNotifier();
},);