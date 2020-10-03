import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';

class HouseCoffeeListPage extends StatelessWidget {
  const HouseCoffeeListPage();
  static const routeName = '/houseCoffeeListPage';
  @override
  Widget build(BuildContext context) {
    context.read(houseCoffeeListController).initState();
    final beanId = ModalRoute.of(context).settings.arguments as int;
    if (beanId == null) {
      context.read(houseCoffeeListController).fetchAll();
    } else {
      context.read(houseCoffeeListController).fetchByBeanId(beanId);
    }

    return WillPopScope(
      onWillPop: () async {
        await context.read(houseCoffeeListController).dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const HouseCoffeeListBody(),
        floatingActionButton: const HouseCoffeeListFab(),
      ),
    );
  }
}

class HouseCoffeeListBody extends ConsumerWidget {
  const HouseCoffeeListBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(houseCoffeeList).state;

    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.separated(
      // updateのたびに順番が逆になる。
      itemCount: state.length,
      itemBuilder: (context, index) {
        return ProviderScope(
          overrides: [
            currentHouseCoffee.overrideWithValue(state[index]),
          ],
          child: const HouseCoffeeListTile(),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}

class HouseCoffeeListFab extends StatelessWidget {
  const HouseCoffeeListFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // houseCoffee を追加
      },
    );
  }
}

final currentHouseCoffee = ScopedProvider<HouseCoffee>((_) => null);

class HouseCoffeeListTile extends ConsumerWidget {
  const HouseCoffeeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentHouseCoffee);

    return Card(
      child: Column(
        children: [
          SizedBox(height: 100, child: ImageByUri(state.imageUri)),
          Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(state.beanName),
              leading: IconButton(
                icon: Icon(
                  (state.isFavorite) ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  context.read(houseCoffeeListController).update(
                        state.copyWith(isFavorite: !state.isFavorite),
                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
