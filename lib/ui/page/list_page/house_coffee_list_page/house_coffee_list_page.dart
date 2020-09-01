import 'package:coffee_life_manager/dialog/show_delete_dialog.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
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
    final coffeeList = context.watch<List<HouseCoffee>>();
    final viewModel = HouseCoffeeListPageViewModel(
      Provider.of(context, listen: false),
    );

    if (coffeeList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (coffeeList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('要素がありません'),
        ),
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
              child: Provider.value(
                value: coffee,
                child: HouseCoffeeListTile(viewModel),
              ),
            ),
        ],
      ),
    );
  }
}

class HouseCoffeeListTile extends StatefulWidget {
  const HouseCoffeeListTile(this.viewModel);

  final HouseCoffeeListPageViewModel viewModel;

  @override
  _HouseCoffeeListTileState createState() => _HouseCoffeeListTileState();
}

class _HouseCoffeeListTileState extends State<HouseCoffeeListTile> {
  HouseCoffee coffee;

  @override
  void initState() {
    coffee = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      actions: [
        FavButton(
          value: coffee.isFavorite,
          onChanged: (val) {
            setState(() {
              coffee.isFavorite = val;
              widget.viewModel.onFavChanged(coffee);
            });
          },
        ),
      ],
      information: coffee,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) =>
                Provider.value(
                  value: coffee,
                  child: HouseCoffeeDetailPage(),
                ),
          ),
        );
        setState(() {
          coffee = coffee;
        });
      },
    );
  }
}
