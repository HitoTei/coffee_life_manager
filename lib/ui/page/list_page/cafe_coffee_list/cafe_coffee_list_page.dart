import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CafeCoffeeListBody(),
        ),
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
      itemCount: state.length + 1,
      itemBuilder: (context, index) {
        if (index == state.length) {
          return const SizedBox(
            height: 56,
          );
        }
        return InkWell(
          onTap: () async {
            final cafeId = ModalRoute.of(context).settings.arguments as int;
            // final cafeCoffee = await Navigator.pushNamed(
            //   context,
            //   cafeId == null
            //      ? CafeCoffeeDetailPage.routeName
            //      : CafeCoffeeDetailPage.routeNameWithNoLinks,
            //   arguments: state[index].uid,
            // );
            // context
            //     .read(cafeCoffeeListController)
            //     .update(cafeCoffee as CafeCoffee ?? state[index]);
          },
          child: Slidable(
            key: ObjectKey(state[index]),
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                caption: '削除する',
                color: Colors.red,
                onTap: () {
                  final cafeCoffee = state[index];
                  context
                      .read(cafeCoffeeListController)
                      .removeOnlyContentsOfList(cafeCoffee);
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text('削除しました'),
                        action: SnackBarAction(
                          label: '元に戻す',
                          onPressed: () {
                            context
                                .read(cafeCoffeeListController)
                                .add(cafeCoffee);
                          },
                        ),
                      ),
                    ).closed.then(
                      (value) {
                        if (value != SnackBarClosedReason.action) {
                          context
                              .read(cafeCoffeeListController)
                              .removeContentsOfRepository(cafeCoffee);
                        }
                      },
                    );
                },
              ),
            ],
            actionPane: const SlidableDrawerActionPane(),
            child: ProviderScope(
              overrides: [
                currentCafeCoffee.overrideWithValue(state[index]),
                currentCafeCoffeeController.overrideWithValue(
                  context.read(cafeCoffeeListController).update,
                ),
              ],
              child: const CafeCoffeeListTile(),
            ),
          ),
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
      onPressed: () async {
        final cafeId = ModalRoute.of(context).settings.arguments as int;
        // final cafeCoffee = await Navigator.pushNamed(
        //   context,
        //   cafeId == null
        //       ? CafeCoffeeDetailPage.routeName
        //       : CafeCoffeeDetailPage.routeNameWithNoLinks,
        // );
        // await context.read(cafeCoffeeListController).add(cafeCoffee as CafeCoffee);
      },
    );
  }
}

final currentCafeCoffee = ScopedProvider<CafeCoffee>((_) => null);
final currentCafeCoffeeController =
    ScopedProvider<Function(CafeCoffee)>((_) => null);

class CafeCoffeeListTile extends ConsumerWidget {
  const CafeCoffeeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentCafeCoffee);
    final update = watch(currentCafeCoffeeController);
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Hero(
      tag: state.uid ?? -1,
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 100, child: ImageByUri(state.imageUri)),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(state.productName),
                subtitle: Text('${state.price}円'),
                trailing: IconButton(
                  icon: Icon(
                    (state.isFavorite) ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    update(
                      state.copyWith(isFavorite: !state.isFavorite),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
