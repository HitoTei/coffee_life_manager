import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
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
        appBar: AppBar(
          title: const Text('カフェコーヒー'),
          actions: const [
            CafeCoffeeOrderMenu(),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(8),
          child: CafeCoffeeListBody(),
        ),
      ),
    );
  }
}

class CafeCoffeeOrderMenu extends ConsumerWidget {
  const CafeCoffeeOrderMenu();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    return PopupMenuButton<CafeCoffeeListSortOrder>(
      child: const Icon(Icons.sort),
      initialValue: watch(cafeCoffeeSortOrder).state,
      onSelected: context.read(cafeCoffeeListController).changeSortOrder,
      itemBuilder: (BuildContext context) => [
        for (final order in CafeCoffeeListSortOrder.values)
          PopupMenuItem(
            child: Text(kCafeCoffeeListSortOrderStr[order]),
            value: order,
          ),
      ],
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
      itemCount: state.length + 1,
      itemBuilder: (context, index) {
        if (index == state.length) {
          return const SizedBox(
            height: 56,
          );
        }
        final cafeCoffee = state[index];

        return ListPageSlidable(
          slidableKey: ObjectKey(cafeCoffee),
          child: ProviderScope(
            overrides: [
              currentCafeCoffee.overrideWithValue(cafeCoffee),
              currentCafeCoffeeUpdater.overrideWithValue(
                context.read(cafeCoffeeListController).update,
              ),
            ],
            child: const CafeCoffeeListTile(),
          ),
          goDetailPage: () async {
            final res = await Navigator.pushNamed(
              context,
              CafeCoffeeDetailPage.routeName,
              arguments: {uidKey: cafeCoffee.uid},
            );
            context
                .read(cafeCoffeeListController)
                .update(res as CafeCoffee ?? cafeCoffee);
          },
          removeFromRepository: () => context
              .read(cafeCoffeeListController)
              .removeFromRepository(cafeCoffee),
          undoDelete: () =>
              context.read(cafeCoffeeListController).add(cafeCoffee),
          imageUri: cafeCoffee.imageUri,
        );
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}
