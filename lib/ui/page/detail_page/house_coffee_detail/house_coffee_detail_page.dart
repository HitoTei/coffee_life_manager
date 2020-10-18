import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/entity/enums/drip.dart';
import 'package:coffee_life_manager/entity/enums/grind.dart';
import 'package:coffee_life_manager/entity/enums/roast.dart';
import 'package:coffee_life_manager/entity/rate.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/house_coffee_detail.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/pick_image_slide_action.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class HouseCoffeeDetailPage extends StatelessWidget {
  const HouseCoffeeDetailPage();
  static const routeName = '/houseCoffeeDetailPage';

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context).settings.arguments as Map<String, int>;
    context.read(houseCoffeeDetailController).init(
          map[uidKey] ?? context.read(houseCoffeeDetail).state?.uid,
          beanId:
              map[beanIdKey] ?? context.read(houseCoffeeDetail).state?.beanId,
        );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
          context,
          context.read(houseCoffeeDetail).state,
        );
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: const HouseCoffeeDetailPageBottomAppBar(),
        body: ListView(
          children: const [
            HouseCoffeeDetailTop(),
            HouseCoffeeDetailBody(),
          ],
        ),
      ),
    );
  }
}

class HouseCoffeeDetailTop extends ConsumerWidget {
  const HouseCoffeeDetailTop();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(houseCoffeeDetail).state;
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
          context.read(houseCoffeeDetailController).setImage,
        ),
        IconSlideAction(
          color: Theme.of(context).canvasColor,
          caption: '商品名を変更',
          icon: Icons.text_fields,
          onTap: () async {
            removeFocus(context);
            final textEditor = TextEditingController()..text = state.beanName;
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
                      await context.read(houseCoffeeDetailController).update(
                            state.copyWith(beanName: textEditor.text),
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
        child: const HouseCoffeeListTile(),
        overrides: [
          currentHouseCoffee.overrideWithValue(state),
          currentHouseCoffeeUpdater.overrideWithValue(
            context.read(houseCoffeeDetailController).update,
          ),
        ],
      ),
    );
  }
}

class HouseCoffeeDetailBody extends ConsumerWidget {
  const HouseCoffeeDetailBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(houseCoffeeDetail).state;
    final bean = watch(parentBean).state;
    final controller = context.read(houseCoffeeDetailController);
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        IntListTile(
          title: const Text('淹れた量'),
          subtitle: Text('${state.numOfCups}杯'),
          value: state.numOfCups,
          onChanged: (val) => controller.update(state.copyWith(numOfCups: val)),
        ),
        GrindListTile(
          value: state.grind,
          onChanged: (val) => controller.update(state.copyWith(grind: val)),
        ),
        DripListTile(
          value: state.drip,
          onChanged: (val) => controller.update(state.copyWith(drip: val)),
        ),
        RoastListTile(
          value: state.roast,
          onChanged: (val) => controller.update(state.copyWith(roast: val)),
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

        const Divider(),
        TextFormField(
          initialValue: state.memo,
          onChanged: (val) => controller.update(state.copyWith(memo: val)),
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'メモ',
          ),
        ),
        const Divider(), //

        if (bean != null) const Text('豆'), // divider
        if (bean != null)
          ProviderScope(
            overrides: [
              currentBean.overrideWithValue(bean),
              currentBeanUpdater.overrideWithValue((_) {}),
            ],
            child: const BeanListTile(),
          ),
      ],
    );
  }
}

class HouseCoffeeDetailPageBottomAppBar extends StatelessWidget {
  const HouseCoffeeDetailPageBottomAppBar();
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
                context.read(houseCoffeeDetail).state,
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
                onPressed: () {
                  final houseCoffee = context.read(houseCoffeeDetail).state;
                  Share.share('''
${houseCoffee.beanName}
${DateFormat.yMMMMd().format(houseCoffee.drinkDay)}に飲みました
焙煎: ${roastStr[houseCoffee.roast.index]}
挽き方: ${grindStr[houseCoffee.grind.index]}
淹れ方: ${dripStr[houseCoffee.drip.index]}
$bitternessDisplayString: ${houseCoffee.rate[0] + 1}
$sournessDisplayString: ${houseCoffee.rate[1] + 1}
$fragranceDisplayString: ${houseCoffee.rate[2] + 1}
$richDisplayString: ${houseCoffee.rate[3] + 1}
$overallDisplayString: ${houseCoffee.rate[4] + 1}
''');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
