import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/entity/cafe.dart';
import 'package:coffee_life_manager/entity/cafe_coffee.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail/cafe_detail.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/day_of_the_week_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/map_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/time_of_day_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/pick_image_slide_action.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/list_page_slidable.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CafeDetailPage extends StatelessWidget {
  const CafeDetailPage();
  static const routeName = '/cafeDetailPage';

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context).settings.arguments as int;
    context.read(cafeDetailController).init(uid);

    return WillPopScope(
      onWillPop: () async {
        await context.read(cafeCoffeeListController).dispose();
        Navigator.pop(
          context,
          context.read(cafeDetail).state,
        );
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: const CafeDetailPageBottomAppBar(),
        body: ListView(
          children: const [
            CafeDetailTop(),
            CafeDetailBody(),
            CoffeeList(),
          ],
        ),
      ),
    );
  }
}

class CoffeeList extends ConsumerWidget {
  const CoffeeList();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeCoffeeList).state;
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        const Text('飲んだコーヒー'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final coffee in state)
                ListPageTile(
                  ProviderScope(
                    overrides: [
                      currentCafeCoffee.overrideWithValue(coffee),
                      currentCafeCoffeeUpdater.overrideWithValue(
                        context.read(cafeCoffeeListController).update,
                      ),
                    ],
                    child:
                        const SizedBox(width: 260, child: CafeCoffeeListTile()),
                  ),
                  () async {
                    final res = await Navigator.pushNamed(
                      context,
                      CafeCoffeeDetailPage.routeName,
                      arguments: {
                        cafeIdKey: context.read(cafeDetail).state.uid,
                        uidKey: coffee.uid
                      },
                    );
                    context
                        .read(cafeCoffeeListController)
                        .update(res as CafeCoffee);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class CafeDetailTop extends ConsumerWidget {
  const CafeDetailTop();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeDetail).state;
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
          context.read(cafeDetailController).setImage,
        ),
        IconSlideAction(
          caption: 'カフェの名前を変更',
          icon: Icons.text_fields,
          onTap: () async {
            removeFocus(context);
            final textEditor = TextEditingController()..text = state.cafeName;
            await showDialog<void>(
              context: context,
              child: AlertDialog(
                content: TextField(
                  controller: textEditor,
                  decoration: const InputDecoration(labelText: 'カフェ'),
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
                      await context.read(cafeDetailController).update(
                            state.copyWith(cafeName: textEditor.text),
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
        child: const CafeListTile(),
        overrides: [
          currentCafe.overrideWithValue(state),
          currentCafeUpdater.overrideWithValue(
            context.read(cafeDetailController).update,
          ),
        ],
      ),
    );
  }
}

class CafeDetailBody extends ConsumerWidget {
  const CafeDetailBody();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(cafeDetail).state;
    final controller = context.read(cafeDetailController);
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        TimeOfDayListTile(
          title: '始業時間',
          value: listToTimeOfDay(state.startTime),
          onChanged: (val) {
            controller.update(
              state.copyWith(startTime: [val.hour, val.minute]),
            );
          },
        ),
        TimeOfDayListTile(
          title: '終業時間',
          value: listToTimeOfDay(state.endTime),
          onChanged: (val) {
            controller.update(
              state.copyWith(endTime: [val.hour, val.minute]),
            );
          },
        ),
        DayOfTheWeekListTile(
          title: const Text('定休日'),
          value: state.regularHoliday,
          onChanged: (val) => controller.update(
            state.copyWith(regularHoliday: val),
          ),
        ),
        MapListTile(
          title: const Text('場所'),
          value: state.mapUrl,
          onChanged: (val) => controller.update(state.copyWith(mapUrl: val)),
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

class CafeDetailPageBottomAppBar extends StatelessWidget {
  const CafeDetailPageBottomAppBar();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
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
                context.read(cafeDetail).state,
              );
            },
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.local_cafe,
                  color: Theme.of(context).accentIconTheme.color,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CafeCoffeeDetailPage.routeName,
                    arguments: {cafeIdKey: context.read(cafeDetail).state.uid},
                  );
                },
              ),
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
