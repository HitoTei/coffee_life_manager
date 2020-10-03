import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: HouseCoffeeListBody(),
        ),
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
      itemCount: state.length + 1,
      itemBuilder: (context, index) {
        if (index == state.length) {
          return const SizedBox(
            height: 56,
          );
        }
        return InkWell(
          onTap: () async {
            // final houseCoffee = await Navigator.pushNamed(
            //   context,
            //   HouseCoffeeDetailPage.routeName,
            //   arguments: state[index].uid,
            // );
            // context
            //     .read(houseCoffeeListController)
            //     .update(houseCoffee as HouseCoffee ?? state[index]);
          },
          child: Slidable(
            key: ObjectKey(state[index]),
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                caption: '削除する',
                color: Colors.red,
                onTap: () {
                  final houseCoffee = state[index];
                  context
                      .read(houseCoffeeListController)
                      .removeOnlyContentsOfList(houseCoffee);
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text('削除しました'),
                        action: SnackBarAction(
                          label: '元に戻す',
                          onPressed: () {
                            context
                                .read(houseCoffeeListController)
                                .add(houseCoffee);
                          },
                        ),
                      ),
                    ).closed.then(
                      (value) {
                        if (value != SnackBarClosedReason.action) {
                          context
                              .read(houseCoffeeListController)
                              .removeContentsOfRepository(houseCoffee);
                        }
                      },
                    );
                },
              ),
            ],
            actionPane: const SlidableDrawerActionPane(),
            child: ProviderScope(
              overrides: [
                currentHouseCoffee.overrideWithValue(state[index]),
                currentHouseCoffeeController.overrideWithValue(
                  context.read(houseCoffeeListController).update,
                ),
              ],
              child: const HouseCoffeeListTile(),
            ),
          ),
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
      onPressed: () async {
        final beanId = ModalRoute.of(context).settings.arguments as int;
        // final houseCoffee = await Navigator.pushNamed(
        //   context,
        //   beanId == null
        //       ? HouseCoffeeDetailPage.routeName
        //       : HouseCoffeeDetailPage.routeNameWithNoLinks,
        // );
        // await context.read(houseCoffeeListController).add(houseCoffee as HouseCoffee);
      },
    );
  }
}

final currentHouseCoffee = ScopedProvider<HouseCoffee>((_) => null);
final currentHouseCoffeeController =
    ScopedProvider<Function(HouseCoffee)>((_) => null);

class HouseCoffeeListTile extends ConsumerWidget {
  const HouseCoffeeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentHouseCoffee);
    final update = watch(currentHouseCoffeeController);
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
                title: Text(state.beanName),
                subtitle: Text('${state.drinkDay}'),
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
