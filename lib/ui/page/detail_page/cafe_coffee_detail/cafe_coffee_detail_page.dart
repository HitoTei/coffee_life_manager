import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail/cafe_coffee_detail.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/pick_image_slide_action.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CafeCoffeeDetailPage extends StatelessWidget {
  const CafeCoffeeDetailPage();
  static const routeName = '/cafeCoffeeDetailPage';
  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context).settings.arguments as Map<String, int>;
    context.read(cafeCoffeeDetailController).init(
          map[uidKey] ?? context.read(cafeCoffeeDetail).state?.uid,
          map[cafeIdKey] ?? context.read(cafeCoffeeDetail).state?.cafeId,
        );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
          context,
          context.read(cafeCoffeeDetail).state,
        );
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: const CafeCoffeeDetailPageBottomAppBar(),
        body: ListView(
          children: const [
            CafeCoffeeDetailTop(),
            CafeCoffeeDetailBody(),
          ],
        ),
      ),
    );
  }
}

class CafeCoffeeDetailTop extends ConsumerWidget {
  const CafeCoffeeDetailTop();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeCoffeeDetail).state;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Slidable(
      key: ObjectKey(state),
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        PickImageSlideAction(
          context.read(cafeCoffeeDetailController).setImage,
        ),
        IconSlideAction(
          caption: '商品名を変更',
          icon: Icons.text_fields,
          onTap: () async {
            removeFocus(context);
            final textEditor = TextEditingController()
              ..text = state.productName;
            await showDialog<void>(
              context: context,
              child: AlertDialog(
                content: TextField(
                  controller: textEditor,
                  decoration: const InputDecoration(labelText: '商品名'),
                ),
                actions: [
                  FlatButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () async {
                      await context.read(cafeCoffeeDetailController).update(
                            state.copyWith(productName: textEditor.text),
                          );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
      child: ProviderScope(
        child: const CafeCoffeeListTile(),
        overrides: [
          currentCafeCoffee.overrideWithValue(state),
          currentCafeCoffeeUpdater.overrideWithValue(
            context.read(cafeCoffeeDetailController).update,
          ),
        ],
      ),
    );
  }
}

class CafeCoffeeDetailBody extends ConsumerWidget {
  const CafeCoffeeDetailBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeCoffeeDetail).state;
    final cafe = watch(parentCafe).state;
    final controller = context.read(cafeCoffeeDetailController);
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        IntListTile(
          title: const Text('値段'),
          subtitle: Text('${state.price}円'),
          value: state.price,
          onChanged: (val) => controller.update(state.copyWith(price: val)),
        ),
        DateTimeListTile(
          title: const Text('飲んだ日'),
          value: state.drinkDay,
          onChanged: (val) => controller.update(state.copyWith(drinkDay: val)),
        ),
        const Divider(),
        ProviderScope(
          overrides: [
            rateState.overrideWithValue(state.rate),
            rateStateUpdater.overrideWithValue(
              (val) => controller.update(
                state.copyWith(rate: val),
              ),
            ),
          ],
          child: const RateWidget(),
        ),
        const Divider(), // divider
        TextFormField(
          initialValue: state.memo,
          onChanged: (val) => controller.update(state.copyWith(memo: val)),
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'メモ',
          ),
        ),
        const Divider(),
        const Text('カフェ'),
        cafe == null
            ? const Center(
                child: Text('カフェは削除されました'),
              )
            : ProviderScope(
                overrides: [
                  currentCafe.overrideWithValue(cafe),
                  currentCafeUpdater.overrideWithValue((_) {})
                ],
                child: const CafeListTile(),
              ),
      ],
    );
  }
}

class CafeCoffeeDetailPageBottomAppBar extends StatelessWidget {
  const CafeCoffeeDetailPageBottomAppBar();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).accentIconTheme.color,
            ),
            onPressed: () {
              Navigator.pop(
                context,
                context.read(cafeCoffeeDetail).state,
              );
            },
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).accentIconTheme.color,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
