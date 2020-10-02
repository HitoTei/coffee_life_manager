import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list/cafe_list.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';

class CafeListPage extends StatelessWidget {
  const CafeListPage();
  static const routeName = '/cafeListPage';
  @override
  Widget build(BuildContext context) {
    context.read(cafeListController).initState();
    context.read(cafeListController).fetchAll();

    return WillPopScope(
      onWillPop: () async {
        await context.read(cafeListController).dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const CafeListBody(),
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
      itemCount: state.length,
      itemBuilder: (context, index) {
        return ProviderScope(
          overrides: [
            currentCafe.overrideWithValue(state[index]),
          ],
          child: const CafeListTile(),
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
      onPressed: () {
        // cafe を追加
        context.read(cafeListController).add(Cafe());
      },
    );
  }
}

final currentCafe = ScopedProvider<Cafe>((_) => null);

class CafeListTile extends ConsumerWidget {
  const CafeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentCafe);

    return Card(
      child: Column(
        children: [
          SizedBox(height: 100, child: ImageByUri(state.imageUri)),
          Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(state.cafeName),
              subtitle: Text('${state.startTime} ~ ${state.endTime}'),
              leading: IconButton(
                icon: Icon(
                  (state.isFavorite) ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  context.read(cafeListController).update(
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
