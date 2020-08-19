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

    return ListView(
      children: [
        for (final bean in beanList)
          ImageCardListTile(
            actions: [
              FavButton(
                isFavorite: bean.isFavorite,
                onChanged: (val) {
                  bean.isFavorite = val;
                  viewModel.onFavChanged(bean);
                },
              ),
            ],
            information: bean,
            gotoDetailPage: () async {
              await Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => BeanDetailPage(bean),
                ),
              );
            },
          ),
      ],
    );
  }
}
