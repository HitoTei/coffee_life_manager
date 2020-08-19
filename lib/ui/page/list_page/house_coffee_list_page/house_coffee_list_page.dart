import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/widget/list_tile/image_card_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'house_coffee_list_page_viewmodel.dart';

class HouseCoffeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coffeeList = Provider.of<List<HouseCoffee>>(context);
    final viewModel = HouseCoffeeListPageViewModel(HouseCoffeeDaoImpl());

    if (coffeeList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      children: [
        for (final coffee in coffeeList)
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
                  builder: (_) => HouseCoffeeDetailPage(coffee),
                ),
              );
            },
          ),
      ],
    );
  }
}
