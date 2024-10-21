import 'package:flutter/material.dart';
import 'package:meals/app/models/meal.dart';
import 'package:meals/app/screens/meal_details.dart';
import 'package:meals/app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget{
  const MealsScreen({super.key, this.title, required this.meals});
  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context,Meal meal){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealDetailsScreen(
              meal: meal,
          )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
            meal: meals[index],
            onSelectMeal: (Meal meal) {
              _selectMeal(context, meal);
            },
        )
    );

    if(meals.isEmpty){
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Uh oh...Nothing here',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface
                ),
            ),
            const SizedBox(height: 16,),
            Text(
                'Try selecting another category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface
              ),
            )
          ],
        ),
      );
    }

    if(title == null){
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!
        ),
      ),
      body: content,
    );
  }
}