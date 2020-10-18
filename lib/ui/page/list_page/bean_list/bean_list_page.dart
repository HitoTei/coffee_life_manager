import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:coffee_life_manager/ui/widget/fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BeanListPage extends StatelessWidget {
  const BeanListPage();
  static const routeName = '/beanListPage';
  @override
  Widget build(BuildContext context) {
    context.read(beanListController).initState();
    final cafeId = ModalRoute.of(context).settings.arguments as int;
    if (cafeId == null) {
      context.read(beanListController).fetchAll();
    } else {
      context.read(beanListController).fetchByCafeId(cafeId);
    }

    return WillPopScope(
      onWillPop: () async {
        await context.read(beanListController).dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('コーヒー豆'),
          actions: const [
            BeanFavButton(),
            BeanOrderMenu(),
          ],
        ),
        body: const BeanListBody(),
        floatingActionButton: const BeanListFab(),
      ),
    );
  }
}

class BeanFavButton extends ConsumerWidget {
  const BeanFavButton();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final opacity = context.read(opacityController);
    return IconButton(
      tooltip: watch(beanFavorite).state ? 'お気に入りのみ表示' : 'すべて表示',
      icon: Icon(
        watch(beanFavorite).state ? Icons.favorite : Icons.favorite_border,
      ),
      onPressed: () {
        opacity.onPageUpdate();
        context.read(beanListController).changeFavorite();
        Fluttertoast.showToast(
          msg: context.read(beanFavorite).state ? 'お気に入りのみ表示' : 'すべて表示',
          gravity: ToastGravity.TOP,
        );
      },
    );
  }
}

class BeanOrderMenu extends ConsumerWidget {
  const BeanOrderMenu();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final opacity = context.read(opacityController);

    return PopupMenuButton<BeanListSortOrder>(
      child: const Icon(Icons.sort),
      initialValue: watch(beanSortOrder).state,
      onSelected: (val) {
        context.read(beanListController).changeSortOrder(val);
        opacity.onPageUpdate();
      },
      itemBuilder: (BuildContext context) => [
        for (final order in BeanListSortOrder.values)
          PopupMenuItem(
            child: Text(kBeanListSortOrderStr[order]),
            value: order,
          ),
      ],
    );
  }
}

class BeanListBody extends ConsumerWidget {
  const BeanListBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(beanList).state;

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
        itemCount: state.length + 1,
        itemBuilder: (context, index) {
          if (index == state.length) {
            return const SizedBox(
              height: 56,
            );
          }
          final bean = state[index];
          return ListPageSlidable(
            slidableKey: ObjectKey(bean),
            child: ProviderScope(
              overrides: [
                currentBean.overrideWithValue(state[index]),
                currentBeanUpdater.overrideWithValue(
                  context.read(beanListController).update,
                ),
              ],
              child: const BeanListTile(),
            ),
            goDetailPage: () async {
              final res = await Navigator.pushNamed(
                context,
                BeanDetailPage.routeName,
                arguments: bean.uid,
              );
              context.read(beanListController).update(res as Bean ?? bean);
            },
            removeFromRepository: () {
              context.read(beanListController).removeFromRepository(bean);
            },
            undoDelete: () {
              context.read(beanListController).add(bean);
            },
            imageUri: bean.imageUri,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(),
      ),
    );
  }
}

class BeanListFab extends StatelessWidget {
  const BeanListFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final bean =
            await Navigator.pushNamed(context, BeanDetailPage.routeName);
        await context.read(beanListController).add(bean as Bean);
      },
    );
  }
}
