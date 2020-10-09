import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class HouseCoffeeListPage extends StatelessWidget {
  const HouseCoffeeListPage();
  static const routeName = '/houseListPage'; // todo: change name
  @override
  Widget build(BuildContext context) {
    context.read(houseCoffeeListController).initState();
    final bean = ModalRoute.of(context).settings.arguments as int;
    if (bean == null) {
      context.read(houseCoffeeListController).fetchAll();
    } else {
      context.read(houseCoffeeListController).fetchByBeanId(bean);
    }

    return WillPopScope(
      onWillPop: () async {
        await context.read(houseCoffeeListController).dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            HouseCoffeeOrderMenu(),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: HouseCoffeeListBody(),
        ),
      ),
    );
  }
}

class HouseCoffeeOrderMenu extends ConsumerWidget {
  const HouseCoffeeOrderMenu();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    return PopupMenuButton<HouseCoffeeListSortOrder>(
      child: const Icon(Icons.sort),
      initialValue: watch(houseCoffeeSortOrder).state,
      onSelected: context.read(houseCoffeeListController).changeSortOrder,
      itemBuilder: (BuildContext context) => [
        for (final order in HouseCoffeeListSortOrder.values)
          PopupMenuItem(
            child: Text(kHouseCoffeeListSortOrderStr[order]),
            value: order,
          ),
      ],
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
      itemCount: state.length + 1,
      itemBuilder: (context, index) {
        if (index == state.length) {
          return const SizedBox(
            height: 56,
          );
        }

        final houseCoffee = state[index];
        return ListPageSlidable(
          slidableKey: ObjectKey(houseCoffee),
          child: ProviderScope(
            overrides: [
              currentHouseCoffee.overrideWithValue(houseCoffee),
              currentHouseCoffeeUpdater.overrideWithValue(
                context.read(houseCoffeeListController).update,
              ),
            ],
            child: const HouseCoffeeListTile(),
          ),
          goDetailPage: () async {
            final res = await Navigator.pushNamed(
              context,
              HouseCoffeeDetailPage.routeName,
              arguments: {uidKey: houseCoffee.uid},
            );
            context
                .read(houseCoffeeListController)
                .update(res as HouseCoffee ?? houseCoffee);
          },
          removeFromList: () => context
              .read(houseCoffeeListController)
              .removeFromList(houseCoffee),
          removeFromRepository: () => context
              .read(houseCoffeeListController)
              .removeFromRepository(houseCoffee),
          undoDelete: () =>
              context.read(houseCoffeeListController).add(houseCoffee),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}
