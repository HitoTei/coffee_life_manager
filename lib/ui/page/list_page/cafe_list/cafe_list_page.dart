import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:coffee_life_manager/ui/widget/fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CafeListPage extends StatelessWidget {
  const CafeListPage();
  static const routeName = '/cafeListPage'; // todo: change name
  @override
  Widget build(BuildContext context) {
    context.read(cafeListController)
      ..initState()
      ..fetchAll();

    return WillPopScope(
      onWillPop: () async {
        await context.read(cafeListController).dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('カフェ'),
          actions: const [
            CafeFavButton(),
            CafeOrderMenu(),
          ],
        ),
        body: const CafeListBody(),
        floatingActionButton: const CafeListFab(),
      ),
    );
  }
}

class CafeFavButton extends ConsumerWidget {
  const CafeFavButton();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final opacity = context.read(opacityController);
    return IconButton(
      tooltip: watch(cafeFavorite).state ? 'お気に入りのみ表示' : 'すべて表示',
      icon: Icon(
        watch(cafeFavorite).state ? Icons.favorite : Icons.favorite_border,
      ),
      onPressed: () {
        opacity.onPageUpdate();
        context.read(cafeListController).changeFavorite();
        Fluttertoast.showToast(
          msg: context.read(cafeFavorite).state ? 'お気に入りのみ表示' : 'すべて表示',
          gravity: ToastGravity.TOP,
        );
      },
    );
  }
}

class CafeOrderMenu extends ConsumerWidget {
  const CafeOrderMenu();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final opacity = context.read(opacityController);

    return PopupMenuButton<CafeListSortOrder>(
      child: const Icon(Icons.sort),
      initialValue: watch(cafeSortOrder).state,
      onSelected: (val) {
        context.read(cafeListController).changeSortOrder(val);
        opacity.onPageUpdate();
      },
      itemBuilder: (BuildContext context) => [
        for (final order in CafeListSortOrder.values)
          PopupMenuItem(
            child: Text(kCafeListSortOrderStr[order]),
            value: order,
          ),
      ],
    );
  }
}

class CafeListBody extends ConsumerWidget {
  const CafeListBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeList).state;

    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.isEmpty) {
      return Center(
        child: RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 20),
            children: [
              TextSpan(text: 'まだ要素がありません\n'),
              TextSpan(text: '右下の'),
              WidgetSpan(child: Icon(Icons.add)),
              TextSpan(text: 'から要素を追加できます'),
            ],
          ),
        ),
      );
    }
    return FadeWidget(
      child: ListView.separated(
        // updateのたびに順番が逆になる。
        itemCount: state.length + 1,
        itemBuilder: (context, index) {
          if (index == state.length) {
            return const SizedBox(
              height: 56,
            );
          }

          final cafe = state[index];
          return ListPageSlidable(
            slidableKey: ObjectKey(cafe),
            child: ProviderScope(
              overrides: [
                currentCafe.overrideWithValue(state[index]),
                currentCafeUpdater.overrideWithValue(
                  context.read(cafeListController).update,
                ),
              ],
              child: const CafeListTile(),
            ),
            goDetailPage: () async {
              final res = await Navigator.pushNamed(
                context,
                CafeDetailPage.routeName,
                arguments: cafe.uid,
              );
              context.read(cafeListController).update(res as Cafe ?? cafe);
            },
            removeFromRepository: () =>
                context.read(cafeListController).removeFromRepository(cafe),
            undoDelete: () => context.read(cafeListController).add(cafe),
            imageUri: cafe.imageUri,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(),
      ),
    );
  }
}

class CafeListFab extends StatelessWidget {
  const CafeListFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'カフェを追加',
      child: const Icon(Icons.add),
      onPressed: () async {
        final cafe = await Navigator.pushNamed(
          context,
          CafeDetailPage.routeName,
        );
        await context.read(cafeListController).add(cafe as Cafe);
      },
    );
  }
}
