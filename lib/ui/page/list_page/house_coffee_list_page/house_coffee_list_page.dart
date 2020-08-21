import 'package:coffee_life_manager/dialog/show_delete_dialog.dart';
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

    return Scaffold(
      body: ListView(
        children: [
          for (final coffee in coffeeList)
            InkWell(
              key: UniqueKey(),
              onTap: () {
                showDeleteDialog(
                  context,
                  () => Provider.of<Function(dynamic)>(context, listen: false)
                      .call(coffee),
                );
              },
              child: HouseCoffeeListTile(coffee, viewModel),
            ),
        ],
      ),
    );
  }
}

class HouseCoffeeListTile extends StatefulWidget {
  const HouseCoffeeListTile(this.coffee, this.viewModel);

  final HouseCoffee coffee;
  final HouseCoffeeListPageViewModel viewModel;

  @override
  _HouseCoffeeListTileState createState() => _HouseCoffeeListTileState();
}

class _HouseCoffeeListTileState extends State<HouseCoffeeListTile> {
  HouseCoffee coffee;

  @override
  void initState() {
    coffee = widget.coffee;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      actions: [
        FavButton(
          isFavorite: widget.coffee.isFavorite,
          onChanged: (val) {
            widget.coffee.isFavorite = val;
            widget.viewModel.onFavChanged(widget.coffee);
          },
        ),
      ],
      information: widget.coffee,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => HouseCoffeeDetailPage(widget.coffee),
          ),
        );
        setState(() {
          coffee = widget.coffee;
        });
      },
    );
  }
}
