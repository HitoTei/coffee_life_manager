import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/entity/enums/roast.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/entity/rate.dart';
import 'package:coffee_life_manager/function/files.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail/bean_detail.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/add_house_coffee_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/map_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/pick_image_slide_action.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class BeanDetailPage extends StatelessWidget {
  const BeanDetailPage();
  static const routeName = '/beanDetailPage';

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context).settings.arguments as int;
    context.read(beanDetailController).init(uid);

    return WillPopScope(
      onWillPop: () async {
        await context.read(houseCoffeeListController).dispose();
        Navigator.pop(
          context,
          context.read(beanDetail).state,
        );
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: const BeanDetailPageBottomAppBar(),
        body: ListView(
          children: const [
            BeanDetailTop(),
            BeanDetailBody(),
            HouseCoffeeList(),
          ],
        ),
      ),
    );
  }
}

class HouseCoffeeList extends ConsumerWidget {
  const HouseCoffeeList();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(houseCoffeeList).state;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.isEmpty) return const SizedBox();

    return Column(
      children: [
        const Text('淹れたコーヒーのリスト'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final coffee in state)
                ListPageTile(
                  ProviderScope(
                    overrides: [
                      currentHouseCoffee.overrideWithValue(coffee),
                      currentHouseCoffeeUpdater.overrideWithValue(
                        context.read(houseCoffeeListController).update,
                      ),
                    ],
                    child: const SizedBox(
                      width: 260,
                      child: HouseCoffeeListTile(),
                    ),
                  ),
                  () async {
                    final res = await Navigator.pushNamed(
                      context,
                      HouseCoffeeDetailPage.routeName,
                      arguments: {
                        beanIdKey: context.read(beanDetail).state.uid,
                        uidKey: coffee.uid
                      },
                    );
                    context
                        .read(houseCoffeeListController)
                        .update(res as HouseCoffee);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class BeanDetailTop extends ConsumerWidget {
  const BeanDetailTop();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(beanDetail).state;
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
          context.read(beanDetailController).setImage,
        ),
        IconSlideAction(
          color: Theme.of(context).canvasColor,
          caption: '豆の名前を\n変更',
          icon: Icons.text_fields,
          onTap: () async {
            removeFocus(context);
            final textEditor = TextEditingController()..text = state.beanName;
            await showEditTextDialog(
              context,
              textEditor,
              onChanged: (val) async {
                await context.read(beanDetailController).update(
                      state.copyWith(beanName: val),
                    );
              },
              title: const Text('豆の名前を変更'),
              initialValue: textEditor.text,
              hintText: '豆の名前を変更',
            );
          },
        ),
      ],
      child: ProviderScope(
        child: const BeanListTile(),
        overrides: [
          currentBean.overrideWithValue(state),
          currentBeanUpdater.overrideWithValue(
            context.read(beanDetailController).update,
          ),
        ],
      ),
    );
  }
}

class BeanDetailBody extends ConsumerWidget {
  const BeanDetailBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(beanDetail).state;
    final controller = context.read(beanDetailController);
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        IntListTile(
          title: const Text('購入したときの量'),
          subtitle: Text('${state.firstAmount}g'),
          value: state.firstAmount,
          onChanged: (val) =>
              controller.update(state.copyWith(firstAmount: val)),
        ),
        IntListTile(
          title: const Text('残量'),
          subtitle: Text('${state.remainingAmount}g'),
          value: state.remainingAmount,
          onChanged: (val) =>
              controller.update(state.copyWith(remainingAmount: val)),
        ),
        IntListTile(
          title: const Text('一杯当たりの豆の量'),
          subtitle: Text('${state.oneCupPerGram}g'),
          value: state.oneCupPerGram,
          onChanged: (val) =>
              controller.update(state.copyWith(oneCupPerGram: val)),
        ),
        IntListTile(
          title: const Text('値段'),
          subtitle: Text('${state.price}円'),
          value: state.price,
          onChanged: (val) => controller.update(state.copyWith(price: val)),
        ),
        ListTile(
          title: (state.firstAmount != 0)
              ? Text('値段 ￥${(state.price * 100) / state.firstAmount}/100g')
              : Text(
                  '購入したときの量が設定されていません',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
        ),
        RoastListTile(
          value: state.roast,
          onChanged: (val) => controller.update(state.copyWith(roast: val)),
        ),
        DateTimeListTile(
          title: const Text('賞味期限'),
          value: state.freshnessDate,
          onChanged: (val) =>
              controller.update(state.copyWith(freshnessDate: val)),
        ),
        DateTimeListTile(
          title: const Text('開封日時'),
          value: state.openTime,
          onChanged: (val) => controller.update(state.copyWith(openTime: val)),
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
      ],
    );
  }
}

class BeanDetailPageBottomAppBar extends StatelessWidget {
  const BeanDetailPageBottomAppBar();
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
                context.read(beanDetail).state,
              );
            },
          ),
          Row(
            children: [
              IconButton(
                tooltip: 'コーヒーを追加',
                icon: Icon(
                  Icons.local_cafe,
                  color: Theme.of(context).accentIconTheme.color,
                ),
                onPressed: () async {
                  final map = await Navigator.pushNamed(
                    context,
                    AddHouseCoffeePage.routeName,
                    arguments: {
                      beanIdKey: context.read(beanDetail).state.uid,
                    },
                  );
                  // 値が戻ってきたら、リスト画面に行く。
                  if (map != null) {
                    final bean = (map as Map<String, dynamic>)['bean'] as Bean;
                    Navigator.pop(context, bean);
                    await Navigator.pushNamed(
                      context,
                      HouseCoffeeDetailPage.routeName,
                      arguments: {
                        uidKey: (map as Map<String, dynamic>)[uidKey] as int,
                        beanIdKey: bean.uid,
                      },
                    );
                  }
                },
              ),
              IconButton(
                tooltip: '共有',
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).accentIconTheme.color,
                ),
                onPressed: () async {
                  final bean = context.read(beanDetail).state;
                  final str = '''
${bean.beanName}
${(bean.openTime == null) ? '未設定' : DateFormat.yMMMMd().format(bean.openTime)}に開封しました
賞味期限: ${(bean.freshnessDate == null) ? '未設定' : DateFormat.yMMMMd().format(bean.freshnessDate)}
焙煎: ${roastStr[bean.roast.index]}
$bitternessDisplayString: ${bean.rate[0] + 1}
$sournessDisplayString: ${bean.rate[1] + 1}
$fragranceDisplayString: ${bean.rate[2] + 1}
$richDisplayString: ${bean.rate[3] + 1}
$sweetnessDisplayString: ${bean.rate[4] + 1}
${bean.memo}
''';
                  if (bean.imageUri != null && bean.imageUri.isNotEmpty) {
                    await Share.shareFiles(
                      [(await getLocalFile(bean.imageUri)).path],
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
