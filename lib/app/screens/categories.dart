import 'package:flutter/material.dart';
import 'package:meals/app/data/dummy_data.dart';
import 'package:meals/app/models/category.dart';
import 'package:meals/app/screens/meals.dart';
import 'package:meals/app/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      upperBound: 1,
      lowerBound: 0,
      duration: const Duration(milliseconds: 300)
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  void _selectCategory(BuildContext context, Category category){
    final filteredMeals = widget.availableMeals.where((meal){
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20
        ),
        children: [
          for(final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () => _selectCategory(context, category),
            )
        ],
      ),
      builder: (context, child){
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.9,
            end: 1
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1
            ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0)
              ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
              child: child,
            ),
          ),
        );
      },
    );
  }
}