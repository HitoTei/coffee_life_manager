import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail/house_coffee_detail.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list/house_coffee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

class HouseCoffeeDetailPage extends StatelessWidget {
  const HouseCoffeeDetailPage();
  static const routeName = '/houseCoffeeDetailPage';

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context).settings.arguments as Map<String, int>;
    context.read(houseCoffeeDetailController).init(
          map[uidKey] ?? context.read(houseCoffeeDetail).state?.uid,
          beanId: map[beanIdKey],
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
        IconSlideAction(
          caption: '画像を変更',
          icon: Icons.image,
          onTap: () async {
            removeFocus(context);
            final image = await await showDialog<Future<PickedFile>>(
              context: context,
              child: SimpleDialog(
                children: [
                  FlatButton(
                    child: const Text('ギャラリーから画像を選択'),
                    onPressed: () async {
                      final image = ImagePicker().getImage(
                        source: ImageSource.gallery,
                      );
                      Navigator.pop(context, image);
                    },
                  ),
                  FlatButton(
                    child: const Text('写真を撮影'),
                    onPressed: () async {
                      final image = ImagePicker().getImage(
                        source: ImageSource.camera,
                      );
                      Navigator.pop(context, image);
                    },
                  ),
                ],
              ),
            );
            if (image != null) {
              await context.read(houseCoffeeDetailController).setImage(image);
            }
          },
        ),
        IconSlideAction(
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
          currentHouseCoffeeController.overrideWithValue(
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
    final controller = context.read(houseCoffeeDetailController);
    if (state == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
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

class HouseCoffeeDetailPageBottomAppBar extends StatelessWidget {
  const HouseCoffeeDetailPageBottomAppBar();
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
                context.read(houseCoffeeDetail).state,
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
