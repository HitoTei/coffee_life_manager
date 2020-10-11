import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';

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
          title: const Text('コーヒー'),
          actions: const [
            BeanOrderMenu(),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(8),
          child: BeanListBody(),
        ),
        floatingActionButton: const BeanListFab(),
      ),
    );
  }
}

class BeanOrderMenu extends ConsumerWidget {
  const BeanOrderMenu();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    return PopupMenuButton<BeanListSortOrder>(
      child: const Icon(Icons.sort),
      initialValue: watch(beanSortOrder).state,
      onSelected: context.read(beanListController).changeSortOrder,
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

    return ListView.separated(
      // updateのたびに順番が逆になる。
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
          removeFromRepository: () =>
              context.read(beanListController).removeFromRepository(bean),
          undoDelete: () => context.read(beanListController).add(bean),
          imageUri: bean.imageUri,
        );
      },
      separatorBuilder: (_, __) => const Divider(),
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
