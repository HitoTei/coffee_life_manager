import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
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
    final beanList = Provider.of<List<Bean>>(context);
    final viewModel = BeanListPageViewModel(BeanDaoImpl());

    if (beanList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          for (final bean in beanList)
            InkWell(
              onLongPress: () {
                Provider.of<Function(dynamic)>(context).call(bean);
              },
              child: _BeanListTile(bean, viewModel),
            ),
        ],
      ),
    );
  }
}

class _BeanListTile extends StatefulWidget {
  const _BeanListTile(this.bean, this.viewModel);

  final Bean bean;
  final BeanListPageViewModel viewModel;

  @override
  __BeanListTileState createState() => __BeanListTileState();
}

class __BeanListTileState extends State<_BeanListTile> {
  Bean bean;

  @override
  void initState() {
    bean = widget.bean;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      actions: [
        FavButton(
          isFavorite: widget.bean.isFavorite,
          onChanged: (val) {
            widget.bean.isFavorite = val;
            widget.viewModel.onFavChanged(widget.bean);
          },
        ),
      ],
      // 挙動がおかしかったら、ここをbeanに変更する。
      information: widget.bean,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => BeanDetailPage(widget.bean),
          ),
        );
        setState(() {
          bean = widget.bean;
        });
      },
    );
  }
}
