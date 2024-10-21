import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/app/models/meal.dart';
import 'package:meals/app/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget{
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: (){
            final isAdded = ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(isAdded ? 'Meal Added To Favorites' : 'Meal Removed From Favorites'),
                  duration: const Duration(milliseconds: 500),
              )
            );
          }, icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween<double>(
                  begin: 0.5,
                  end: 1
                ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                child: child,
              );
            },
            child: Icon(
                isFavorite ? Icons.star : Icons.star_border_outlined,
                key: ValueKey(isFavorite),
            )
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14,),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 14,),
            for(final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface
                ),
              ),
            const SizedBox(height: 24,),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 14,),
            for(final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}