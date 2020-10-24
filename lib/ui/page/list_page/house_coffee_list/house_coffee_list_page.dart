import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/myadmob.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:coffee_life_manager/ui/widget/fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HouseCoffeeListPage extends StatelessWidget {
  const HouseCoffeeListPage();
  static const routeName = '/houseListPage';
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
          title: const Text('家コーヒー'),
          actions: const [
            HouseCoffeeFavButton(),
            HouseCoffeeOrderMenu(),
          ],
        ),
        body: const HouseCoffeeListBody(),
      ),
    );
  }
}

class HouseCoffeeFavButton extends ConsumerWidget {
  const HouseCoffeeFavButton();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final opacity = context.read(opacityController);

    return IconButton(
      tooltip: watch(houseCoffeeFavorite).state ? 'お気に入りのみ表示' : 'すべて表示',
      icon: Icon(
        watch(houseCoffeeFavorite).state
            ? Icons.favorite
            : Icons.favorite_border,
      ),
      onPressed: () {
        opacity.onPageUpdate();
        context.read(houseCoffeeListController).changeFavorite();
        Fluttertoast.showToast(
          msg: context.read(houseCoffeeFavorite).state ? 'お気に入りのみ表示' : 'すべて表示',
          gravity: ToastGravity.TOP,
        );
      },
    );
  }
}

class HouseCoffeeOrderMenu extends ConsumerWidget {
  const HouseCoffeeOrderMenu();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final opacity = context.read(opacityController);

    return PopupMenuButton<HouseCoffeeListSortOrder>(
      child: const Icon(Icons.sort),
      initialValue: watch(houseCoffeeSortOrder).state,
      onSelected: (val) {
        opacity.onPageUpdate();
        context.read(houseCoffeeListController).changeSortOrder(val);
      },
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

    return FadeWidget(
      child: ListView.separated(
        // updateのたびに順番が逆になる。
        itemCount: state.length + 1,
        itemBuilder: (context, index) {
          if (state.isEmpty) {
            return Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: [
                    TextSpan(text: 'まだ要素がありません\n'),
                    TextSpan(text: '豆の'),
                    WidgetSpan(child: Icon(Icons.local_cafe)),
                    TextSpan(text: 'から要素を追加できます'),
                  ],
                ),
              ),
            );
          }

          if (index == state.length) {
            return const SizedBox(
              height: 56,
            );
          }

          final houseCoffee = state[index];
          return Column(
            children: [
              if (index % 5 == 0) MyBannerAdMob(),
              ListPageSlidable(
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
                removeFromRepository: () => context
                    .read(houseCoffeeListController)
                    .removeFromRepository(houseCoffee),
                undoDelete: () =>
                    context.read(houseCoffeeListController).add(houseCoffee),
                imageUri: houseCoffee.imageUri,
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(),
      ),
    );
  }
}
