import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'meals_provider.dart';

enum Filters{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}


class FiltersNotifier extends StateNotifier<Map<Filters, bool>>{
  FiltersNotifier(): super({
    Filters.glutenFree:false,
    Filters.lactoseFree:false,
    Filters.vegetarian:false,
    Filters.vegan:false,
  });

  void setFilters(Map<Filters, bool> chosenFilters){
    state = chosenFilters;
  }

  void setFilter(Filters filter, bool isActive){
    state = {
      ...state,
      filter: isActive
    };
  }
}

final filterProvider = StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>((ref){
  return FiltersNotifier();
});

final filteredMealsProvider = Provider((ref){
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filterProvider);
  final availableMeals = meals.where((meal){
    if(selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(selectedFilters[Filters.vegan]! && !meal.isVegan){
      return false;
    }
    if(selectedFilters[Filters.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    return true;
  }).toList();
  return availableMeals;
});