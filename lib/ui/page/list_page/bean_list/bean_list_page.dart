import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
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
        appBar: AppBar(),
        body: const BeanListBody(),
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
      itemCount: state.length,
      itemBuilder: (context, index) {
        return ProviderScope(
          overrides: [
            currentBean.overrideWithValue(state[index]),
          ],
          child: const BeanListTile(),
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
      onPressed: () {
        // bean を追加
        context.read(beanListController).add(Bean());
      },
    );
  }
}

final currentBean = ScopedProvider<Bean>((_) => null);

class BeanListTile extends ConsumerWidget {
  const BeanListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentBean);

    return Card(
      child: Column(
        children: [
          SizedBox(height: 100, child: ImageByUri(state.imageUri)),
          Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(state.beanName),
              subtitle: Text('残り${state.remainingAmount}g'),
              leading: IconButton(
                icon: Icon(
                  (state.isFavorite) ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  context.read(beanListController).update(
                        state.copyWith(isFavorite: !state.isFavorite),
                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
