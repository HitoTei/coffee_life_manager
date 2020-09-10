import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list_page/house_coffee_list_tile_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/image_card_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseCoffeeListTile extends StatefulWidget {
  @override
  _HouseCoffeeListTileState createState() => _HouseCoffeeListTileState();
}

class _HouseCoffeeListTileState extends State<HouseCoffeeListTile> {
  HouseCoffeeListTileViewModel viewModel;

  @override
  void initState() {
    viewModel = HouseCoffeeListTileViewModel(
      context.read(),
      context.read(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      viewModel: viewModel,
      information: viewModel.coffee,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => Provider.value(
              value: viewModel.coffee,
              child: HouseCoffeeDetailPage(),
            ),
          ),
        );

        final coffee = await context
            .read<HouseCoffeeDao>()
            .fetchByUid(viewModel.coffee.uid);

        setState(() {
          viewModel
            ..coffee = coffee
            ..onFavChanged(coffee.isFavorite);
        });
      },
    );
  }
}
