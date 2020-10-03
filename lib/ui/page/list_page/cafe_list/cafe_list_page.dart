import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CafeListBody(),
        ),
        floatingActionButton: const CafeListFab(),
      ),
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
            final cafe = await Navigator.pushNamed(
              context,
              CafeDetailPage.routeName,
              arguments: state[index].uid,
            );
            context
                .read(cafeListController)
                .update(cafe as Cafe ?? state[index]);
          },
          child: Slidable(
            key: ObjectKey(state[index]),
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                caption: '削除する',
                color: Colors.red,
                onTap: () {
                  final cafe = state[index];
                  context
                      .read(cafeListController)
                      .removeOnlyContentsOfList(cafe);
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text('削除しました'),
                        action: SnackBarAction(
                          label: '元に戻す',
                          onPressed: () {
                            context.read(cafeListController).add(cafe);
                          },
                        ),
                      ),
                    ).closed.then(
                      (value) {
                        if (value != SnackBarClosedReason.action) {
                          context
                              .read(cafeListController)
                              .removeContentsOfRepository(cafe);
                        }
                      },
                    );
                },
              ),
            ],
            actionPane: const SlidableDrawerActionPane(),
            child: ProviderScope(
              overrides: [
                currentCafe.overrideWithValue(state[index]),
                currentCafeController.overrideWithValue(
                  context.read(cafeListController).update,
                ),
              ],
              child: const CafeListTile(),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}

class CafeListFab extends StatelessWidget {
  const CafeListFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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

final currentCafe = ScopedProvider<Cafe>((_) => null);
final currentCafeController = ScopedProvider<Function(Cafe)>((_) => null);

class CafeListTile extends ConsumerWidget {
  const CafeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentCafe);
    final update = watch(currentCafeController);
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
                title: Text(state.cafeName),
                subtitle: Text('${state.startTime} ~ ${state.endTime}'),
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
