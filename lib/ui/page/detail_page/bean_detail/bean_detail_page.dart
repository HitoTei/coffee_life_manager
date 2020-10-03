import 'package:coffee_life_manager/ui/page/detail_page/bean_detail/bean_detail.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list/bean_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

class BeanDetailPage extends StatelessWidget {
  const BeanDetailPage();
  static const routeName = '/beanDetailPage';

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context).settings.arguments as int;
    context.read(beanDetailController).init(uid);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
          context,
          context.read(beanDetail).state,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: const [],
        ),
        body: ListView(
          children: const [
            BeanDetailTop(),
            BeanDetailBody(),
          ],
        ),
      ),
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
        IconSlideAction(
          caption: '画像を変更',
          icon: Icons.image,
          onTap: () async {
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
              await context.read(beanDetailController).setImage(image);
            }
          },
        ),
        IconSlideAction(
          caption: '豆の名前を変更',
          icon: Icons.text_fields,
          onTap: () async {
            final textEditor = TextEditingController()..text = state.beanName;
            await showDialog<void>(
              context: context,
              child: AlertDialog(
                content: TextField(
                  controller: textEditor,
                  decoration: const InputDecoration(labelText: '豆の名前を変更'),
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
                      await context.read(beanDetailController).update(
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
        child: const BeanListTile(),
        overrides: [
          currentBean.overrideWithValue(state),
          currentBeanController.overrideWithValue(
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
          title: const Text('購入したときの量'),
          subtitle: Text('${state.firstAmount}g'),
          value: state.firstAmount,
          onChanged: (val) =>
              controller.update(state.copyWith(firstAmount: val)),
        ),
        IntListTile(
          title: const Text('値段'),
          subtitle: Text('${state.price}円'),
          value: state.price,
          onChanged: (val) => controller.update(state.copyWith(price: val)),
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
        ),
      ],
    );
  }
}
