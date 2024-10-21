import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/app/providers/favorites_provider.dart';
import 'package:meals/app/providers/filters_provider.dart';
import 'package:meals/app/screens/categories.dart';
import 'package:meals/app/screens/filters.dart';
import 'package:meals/app/screens/meals.dart';
import 'package:meals/app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen>{
  int selectedPageIndex = 0;
  void selectPage(int index){
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier){
    Navigator.of(context).pop();
    if(identifier == 'filters'){
      Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
            builder: (ctx)=>  const FiltersScreen()
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(availableMeals: availableMeals,);
    String activePageTitle = 'Categories';

    if(selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
          meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites'
          ),
        ]
      ),
    );
  }
  
}