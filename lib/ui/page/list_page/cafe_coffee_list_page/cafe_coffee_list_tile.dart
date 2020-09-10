import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail_page/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list_page/cafe_coffee_list_tile_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/image_card_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeCoffeeListTile extends StatefulWidget {
  @override
  CafeCoffeeListTileState createState() => CafeCoffeeListTileState();
}

class CafeCoffeeListTileState extends State<CafeCoffeeListTile> {
  CafeCoffeeListTileViewModel viewModel;

  @override
  void initState() {
    viewModel = CafeCoffeeListTileViewModel(
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
              child: CafeCoffeeDetailPage(),
            ),
          ),
        );

        setState(() {
          viewModel
            ..coffee = viewModel.coffee
            ..onFavChanged(viewModel.coffee.isFavorite);
        });
      },
    );
  }
}
