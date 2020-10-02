import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';

class CafeCoffeeListPage extends StatelessWidget {
  const CafeCoffeeListPage();
  static const routeName = '/cafeCoffeeListPage';
  @override
  Widget build(BuildContext context) {
    context.read(cafeCoffeeListController).initState();
    final cafeId = ModalRoute.of(context).settings.arguments as int;
    if (cafeId == null) {
      context.read(cafeCoffeeListController).fetchAll();
    } else {
      context.read(cafeCoffeeListController).fetchByCafeId(cafeId);
    }

    return WillPopScope(
      onWillPop: () async {
        await context.read(cafeCoffeeListController).dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const CafeCoffeeListBody(),
        floatingActionButton: const CafeCoffeeListFab(),
      ),
    );
  }
}

class CafeCoffeeListBody extends ConsumerWidget {
  const CafeCoffeeListBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeCoffeeList).state;

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
            currentCafeCoffee.overrideWithValue(state[index]),
          ],
          child: const CafeCoffeeListTile(),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}

class CafeCoffeeListFab extends StatelessWidget {
  const CafeCoffeeListFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // cafeCoffee を追加
      },
    );
  }
}

final currentCafeCoffee = ScopedProvider<CafeCoffee>((_) => null);

class CafeCoffeeListTile extends ConsumerWidget {
  const CafeCoffeeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentCafeCoffee);

    return Card(
      child: Column(
        children: [
          SizedBox(height: 100, child: ImageByUri(state.imageUri)),
          Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(state.productName),
              leading: IconButton(
                icon: Icon(
                  (state.isFavorite) ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  context.read(cafeCoffeeListController).update(
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
