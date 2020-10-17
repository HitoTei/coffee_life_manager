import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/ui/widget/future_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';

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

const _kTileHeight = 200.0;

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
    return _ListTile(
      state,
      state.imageUri,
      ListTile(
        title: Text(
          state.beanName,
          style: const TextStyle(color: Colors.black87),
        ),
        subtitle: Text(
          '残り${state.remainingAmount}g',
          style: const TextStyle(color: Colors.black87),
        ),
        trailing: _FavoriteButton(
          state.isFavorite,
          () => update(
            state.copyWith(isFavorite: !state.isFavorite),
          ),
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
    return _ListTile(
      state,
      state.imageUri,
      ListTile(
        title: Text(
          state.productName,
          style: const TextStyle(color: Colors.black87),
        ),
        subtitle: Text(
          '${(state?.drinkDay != null) ? DateFormat.yMMMMd().format(state?.drinkDay) : '未設定'}',
          style: const TextStyle(color: Colors.black87),
        ),
        trailing: _FavoriteButton(
          state.isFavorite,
          () => update(
            state.copyWith(isFavorite: !state.isFavorite),
          ),
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
    return _ListTile(
      state,
      state.imageUri,
      ListTile(
        title: Text(
          state.cafeName,
          style: const TextStyle(color: Colors.black87),
        ),
        subtitle: Text(
          '${listToTimeOfDay(state.startTime).format(context)}'
          ' ~ '
          '${listToTimeOfDay(state.endTime).format(context)}',
          style: const TextStyle(color: Colors.black87),
        ),
        trailing: _FavoriteButton(
          state.isFavorite,
          () => update(
            state.copyWith(isFavorite: !state.isFavorite),
          ),
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
    return _ListTile(
      state,
      state.imageUri,
      ListTile(
        title: Text(
          state.beanName,
          style: const TextStyle(color: Colors.black87),
        ),
        subtitle: Text(
          '${(state?.drinkDay != null) ? DateFormat.yMMMMd().format(state?.drinkDay) : '未設定'}',
          style: const TextStyle(color: Colors.black87),
        ),
        trailing: _FavoriteButton(
          state.isFavorite,
          () => update(
            state.copyWith(isFavorite: !state.isFavorite),
          ),
        ),
      ),
    );
  }
}

final isNotHero = ScopedProvider<bool>((_) => null);

class _ListTile extends ConsumerWidget {
  const _ListTile(this.tag, this.imageUri, this.child);
  final dynamic tag;
  final String imageUri;
  final Widget child;
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final widget = Card(
      child: SizedBox(
        height: _kTileHeight,
        child: Stack(
          children: [
            SizedBox(
              height: _kTileHeight,
              width: MediaQuery.of(context).size.width,
              child: ProviderScope(
                overrides: [imageByUri.overrideWithValue(imageUri)],
                child: const ImageByUri(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white70,
                ),
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
    if (watch(isNotHero) == null) {
      return Hero(
        tag: tag,
        child: widget,
      );
    } else {
      return widget;
    }
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton(this.isFavorite, this.onPressed);
  final bool isFavorite;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.pink : Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}
