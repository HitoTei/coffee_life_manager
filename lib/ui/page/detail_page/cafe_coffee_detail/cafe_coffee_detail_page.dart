import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/entity/rate.dart';
import 'package:coffee_life_manager/function/files.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail/cafe_coffee_detail.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/map_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/pick_image_slide_action.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

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
          color: Theme.of(context).canvasColor,
          caption: '商品名を変更',
          icon: Icons.text_fields,
          onTap: () async {
            removeFocus(context);
            final textEditor = TextEditingController()
              ..text = state.productName;
            await showEditTextDialog(
              context,
              textEditor,
              onChanged: (val) async {
                await context.read(cafeCoffeeDetailController).update(
                      state.copyWith(productName: val),
                    );
              },
              title: const Text('商品の名前を変更'),
              initialValue: textEditor.text,
              hintText: '商品の名前を変更',
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
        if (cafe != null) const Text('カフェ'),
        if (cafe != null)
          ProviderScope(
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
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            tooltip: '戻る',
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
                tooltip: '共有',
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).accentIconTheme.color,
                ),
                onPressed: () async {
                  final cafeCoffee = context.read(cafeCoffeeDetail).state;
                  final str = '''
${cafeCoffee.productName}
${context.read(parentCafe).state.cafeName}で
${DateFormat.yMMMMd().format(cafeCoffee.drinkDay)}に飲みました
値段: ${cafeCoffee.price}円
$bitternessDisplayString: ${cafeCoffee.rate[0] + 1}
$sournessDisplayString: ${cafeCoffee.rate[1] + 1}
$fragranceDisplayString: ${cafeCoffee.rate[2] + 1}
$richDisplayString: ${cafeCoffee.rate[3] + 1}
$sweetnessDisplayString: ${cafeCoffee.rate[4] + 1}
${cafeCoffee.memo}
''';
                  if (cafeCoffee.imageUri != null &&
                      cafeCoffee.imageUri.isNotEmpty) {
                    await Share.shareFiles(
                      [
                        (await getLocalFile(cafeCoffee.imageUri)).path,
                      ],
                      text: str,
                    );
                  } else {
                    await Share.share(str);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
