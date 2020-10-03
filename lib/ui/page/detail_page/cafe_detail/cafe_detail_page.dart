import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail/cafe_detail.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list/cafe_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/tile/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

class CafeDetailPage extends StatelessWidget {
  const CafeDetailPage();
  static const routeName = '/cafeDetailPage';

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context).settings.arguments as int;
    context.read(cafeDetailController).init(uid);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
          context,
          context.read(cafeDetail).state,
        );
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: const CafeDetailPageBottomAppBar(),
        body: ListView(
          children: [
            const CafeDetailTop(),
            const CafeDetailBody(),
            ListTile(
              title: const Text('飲んだコーヒー'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CafeCoffeeListPage.routeName,
                  arguments: context.read(cafeDetail).state.uid,
                );
              },
            ),
          ],
        ),
      ),
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
              await context.read(cafeDetailController).setImage(image);
            }
          },
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
        const Divider(),
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
