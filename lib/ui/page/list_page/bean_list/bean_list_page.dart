import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BeanListPage extends StatelessWidget {
  const BeanListPage();
  static const routeName = '/'; // todo: change name
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
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: BeanListBody(),
        ),
        floatingActionButton: const BeanListFab(),
      ),
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
        return InkWell(
          onTap: () async {
            final cafeId = ModalRoute.of(context).settings.arguments as int;
            final bean = await Navigator.pushNamed(
              context,
              BeanDetailPage.routeName,
              arguments: state[index].uid,
            );
            context
                .read(beanListController)
                .update(bean as Bean ?? state[index]);
          },
          child: Slidable(
            key: ObjectKey(state[index]),
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                caption: '削除する',
                color: Colors.red,
                onTap: () {
                  final bean = state[index];
                  context
                      .read(beanListController)
                      .removeOnlyContentsOfList(bean);
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text('削除しました'),
                        action: SnackBarAction(
                          label: '元に戻す',
                          onPressed: () {
                            context.read(beanListController).add(bean);
                          },
                        ),
                      ),
                    ).closed.then(
                      (value) {
                        if (value != SnackBarClosedReason.action) {
                          context
                              .read(beanListController)
                              .removeContentsOfRepository(bean);
                        }
                      },
                    );
                },
              ),
            ],
            actionPane: const SlidableDrawerActionPane(),
            child: ProviderScope(
              overrides: [
                currentBean.overrideWithValue(state[index]),
                currentBeanController.overrideWithValue(
                  context.read(beanListController).update,
                ),
              ],
              child: const BeanListTile(),
            ),
          ),
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

final currentBean = ScopedProvider<Bean>((_) => null);
final currentBeanController = ScopedProvider<Function(Bean)>((_) => null);

class BeanListTile extends ConsumerWidget {
  const BeanListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentBean);
    final update = watch(currentBeanController);
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
                subtitle: Text('残り${state.remainingAmount}g'),
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
