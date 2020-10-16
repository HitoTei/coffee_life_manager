import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import '../../constant_string.dart';
import 'detail_page/bean_detail/bean_detail_page.dart';
import 'detail_page/cafe_coffee_detail/cafe_coffee_detail_page.dart';
import 'detail_page/cafe_detail/cafe_detail_page.dart';
import 'detail_page/house_coffee_detail/house_coffee_detail_page.dart';
import 'list_page/bean_list/bean_list.dart';
import 'list_page/cafe_list/cafe_list.dart';
import 'list_page/house_coffee_list/house_coffee_list.dart';
import 'list_page/tile/list_page_slidable.dart';
import 'list_page/tile/tiles.dart';

class HouseCoffeeListView extends StatelessWidget {
  const HouseCoffeeListView();
  @override
  Widget build(BuildContext context) {
    context.read(houseCoffeeListController).fetchAll();
    return WillPopScope(
      onWillPop: () async {
        await context.read(houseCoffeeListController).dispose();
        return false;
      },
      child: ProviderScope(overrides: [
        isNotHero.overrideWithValue(true),
      ], child: const _HouseCoffeeListView()),
    );
  }
}

class _HouseCoffeeListView extends ConsumerWidget {
  const _HouseCoffeeListView();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(houseCoffeeList).state;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final coffee in state)
            ListPageTile(
              ProviderScope(
                overrides: [
                  currentHouseCoffee.overrideWithValue(coffee),
                  currentHouseCoffeeUpdater.overrideWithValue(
                    context.read(houseCoffeeListController).update,
                  ),
                ],
                child: const SizedBox(width: 260, child: HouseCoffeeListTile()),
              ),
              () async {
                final res = await Navigator.pushNamed(
                  context,
                  HouseCoffeeDetailPage.routeName,
                  arguments: {uidKey: coffee.uid},
                );
                context
                    .read(houseCoffeeListController)
                    .update(res as HouseCoffee);
              },
            ),
        ],
      ),
    );
  }
}

class CafeCoffeeListView extends StatelessWidget {
  const CafeCoffeeListView();
  @override
  Widget build(BuildContext context) {
    context.read(cafeCoffeeListController).fetchAll();
    return WillPopScope(
      onWillPop: () async {
        await context.read(cafeCoffeeListController).dispose();
        return false;
      },
      child: ProviderScope(overrides: [
        isNotHero.overrideWithValue(true),
      ], child: const _CafeCoffeeListView()),
    );
  }
}

class _CafeCoffeeListView extends ConsumerWidget {
  const _CafeCoffeeListView();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeCoffeeList).state;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final coffee in state)
            ListPageTile(
              ProviderScope(
                overrides: [
                  currentCafeCoffee.overrideWithValue(coffee),
                  currentCafeCoffeeUpdater.overrideWithValue(
                    context.read(cafeCoffeeListController).update,
                  ),
                ],
                child: const SizedBox(width: 260, child: CafeCoffeeListTile()),
              ),
              () async {
                final res = await Navigator.pushNamed(
                  context,
                  CafeCoffeeDetailPage.routeName,
                  arguments: {uidKey: coffee.uid},
                );
                context
                    .read(cafeCoffeeListController)
                    .update(res as CafeCoffee);
              },
            ),
        ],
      ),
    );
  }
}

class CafeListView extends StatelessWidget {
  const CafeListView();
  @override
  Widget build(BuildContext context) {
    context.read(cafeListController).fetchAll();
    return WillPopScope(
      onWillPop: () async {
        await context.read(cafeListController).dispose();
        return false;
      },
      child: ProviderScope(
        overrides: [
          isNotHero.overrideWithValue(true),
        ],
        child: const _CafeListView(),
      ),
    );
  }
}

class _CafeListView extends ConsumerWidget {
  const _CafeListView();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeList).state;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final cafe in state)
            ListPageTile(
              ProviderScope(
                overrides: [
                  currentCafe.overrideWithValue(cafe),
                  currentCafeUpdater.overrideWithValue(
                    context.read(cafeListController).update,
                  ),
                ],
                child: const SizedBox(width: 260, child: CafeListTile()),
              ),
              () async {
                final res = await Navigator.pushNamed(
                  context,
                  CafeDetailPage.routeName,
                  arguments: cafe.uid,
                );
                context.read(cafeListController).update(res as Cafe);
              },
            ),
        ],
      ),
    );
  }
}

class BeanListView extends StatelessWidget {
  const BeanListView();
  @override
  Widget build(BuildContext context) {
    context.read(beanListController).fetchAll();
    return WillPopScope(
      onWillPop: () async {
        await context.read(beanListController).dispose();
        return false;
      },
      child: ProviderScope(
        overrides: [
          isNotHero.overrideWithValue(true),
        ],
        child: const _BeanListView(),
      ),
    );
  }
}

class _BeanListView extends ConsumerWidget {
  const _BeanListView();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(beanList).state;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final bean in state)
            ListPageTile(
              ProviderScope(
                overrides: [
                  currentBean.overrideWithValue(bean),
                  currentBeanUpdater.overrideWithValue(
                    context.read(beanListController).update,
                  ),
                ],
                child: const SizedBox(width: 260, child: BeanListTile()),
              ),
              () async {
                final res = await Navigator.pushNamed(
                  context,
                  BeanDetailPage.routeName,
                  arguments: bean.uid,
                );
                context.read(beanListController).update(res as Bean);
              },
            ),
        ],
      ),
    );
  }
}
