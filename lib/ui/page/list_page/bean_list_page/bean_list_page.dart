import 'package:coffee_life_manager/dialog/show_delete_dialog.dart';
import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list_page/bean_list_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/widget/list_tile/image_card_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeanListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final beanList = context.watch<List<Bean>>();
    final viewModel = BeanListPageViewModel(context.watch());

    if (beanList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (beanList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('要素がありません'),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          for (final bean in beanList)
            InkWell(
              key: UniqueKey(),
              onLongPress: () {
                showDeleteDialog(
                  context,
                  () => Provider.of<Function(dynamic)>(context, listen: false)
                      .call(bean),
                );
              },
              child: Provider.value(
                value: bean,
                child: _BeanListTile(viewModel),
              ),
            ),
        ],
      ),
    );
  }
}

class _BeanListTile extends StatefulWidget {
  const _BeanListTile(this.viewModel);

  final BeanListPageViewModel viewModel;

  @override
  __BeanListTileState createState() => __BeanListTileState();
}

class __BeanListTileState extends State<_BeanListTile> {
  Bean bean;

  @override
  void initState() {
    bean = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      actions: [
        FavButton(
          value: bean.isFavorite,
          onChanged: (val) {
            setState(() {
              bean.isFavorite = val;
              widget.viewModel.onFavChanged(bean);
            });
          },
        ),
      ],
      // 挙動がおかしかったら、ここをbeanに変更する。
      information: bean,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => Provider.value(
              value: bean,
              child: BeanDetailPage(),
            ),
          ),
        );
        setState(() {
          bean = bean;
        });
      },
    );
  }
}
