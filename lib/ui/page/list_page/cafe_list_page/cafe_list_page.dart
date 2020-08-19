import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/widget/list_tile/image_card_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cafe_list_page_viewmodel.dart';

class CafeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cafeList = Provider.of<List<Cafe>>(context);
    final viewModel = CafeListPageViewModel(CafeDaoImpl());

    if (cafeList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      children: [
        for (final coffee in cafeList)
          ImageCardListTile(
            actions: [
              FavButton(
                isFavorite: coffee.isFavorite,
                onChanged: (val) {
                  coffee.isFavorite = val;
                  viewModel.onFavChanged(coffee);
                },
              ),
            ],
            information: coffee,
            gotoDetailPage: () async {
              await Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => CafeDetailPage(coffee),
                ),
              );
            },
          ),
      ],
    );
  }
}
