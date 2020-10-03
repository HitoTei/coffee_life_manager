import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final currentBean = ScopedProvider<Bean>((_) => null);
final currentBeanUpdater = ScopedProvider<Function(Bean)>((_) => null);

final currentCafeCoffee = ScopedProvider<CafeCoffee>((_) => null);
final currentCafeCoffeeUpdater =
    ScopedProvider<Function(CafeCoffee)>((_) => null);
final currentCafe = ScopedProvider<Cafe>((_) => null);
final currentCafeUpdater = ScopedProvider<Function(Cafe)>((_) => null);

final currentHouseCoffee = ScopedProvider<HouseCoffee>((_) => null);
final currentHouseCoffeeUpdater =
    ScopedProvider<Function(HouseCoffee)>((_) => null);

class BeanListTile extends ConsumerWidget {
  const BeanListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentBean);
    final update = watch(currentBeanUpdater);
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

class CafeCoffeeListTile extends ConsumerWidget {
  const CafeCoffeeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentCafeCoffee);
    final update = watch(currentCafeCoffeeUpdater);
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

class CafeListTile extends ConsumerWidget {
  const CafeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentCafe);
    final update = watch(currentCafeUpdater);
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

class HouseCoffeeListTile extends ConsumerWidget {
  const HouseCoffeeListTile();

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(currentHouseCoffee);
    final update = watch(currentHouseCoffeeUpdater);
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
                subtitle: Text('${state.drinkDay ?? '未設定'}'),
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
