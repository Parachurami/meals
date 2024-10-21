import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/app/providers/filters_provider.dart';


class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
      ),
      // drawer: MainDrawer(
      //     onSelectScreen: (identifier){
      //       Navigator.of(context).pop();
      //       if(identifier == 'meals'){
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(
      //               builder: (ctx) => const TabsScreen()
      //           )
      //         );
      //       }
      //     }
      // ),
      body: Column(
        children: [
          SwitchListTile(
            value: currentFilters[Filters.glutenFree]!,
            onChanged: (isChecked) {
              ref.read(filterProvider.notifier).setFilter(
                  Filters.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: currentFilters[Filters.lactoseFree]!,
            onChanged: (isChecked) {
              ref.read(filterProvider.notifier).setFilter(
                  Filters.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            subtitle: Text(
              'Only include lactose-free meals',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: currentFilters[Filters.vegetarian]!,
            onChanged: (isChecked) {
              ref.read(filterProvider.notifier).setFilter(
                  Filters.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            subtitle: Text(
              'Only include vegetarian meals',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: currentFilters[Filters.vegan]!,
            onChanged: (isChecked) {
              ref.read(filterProvider.notifier).setFilter(
                  Filters.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            subtitle: Text(
              'Only include vegan meals',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface
              ),
            ),
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
