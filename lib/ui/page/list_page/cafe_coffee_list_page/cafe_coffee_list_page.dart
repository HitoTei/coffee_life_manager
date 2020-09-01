import 'package:coffee_life_manager/dialog/show_delete_dialog.dart';
import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail_page/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list_page/cafe_coffee_list_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/widget/list_tile/image_card_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeCoffeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coffeeList = context.watch<List<CafeCoffee>>();
    final viewModel = CafeCoffeeListPageViewModel(
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
              onLongPress: () {
                showDeleteDialog(
                  context,
                  () => Provider.of<Function(dynamic)>(context, listen: false)
                      .call(coffee),
                );
              },
              child: Provider.value(
                value: coffee,
                child: _CafeCoffeeListTile(viewModel),
              ),
            ),
        ],
      ),
    );
  }
}

class _CafeCoffeeListTile extends StatefulWidget {
  const _CafeCoffeeListTile(this.viewModel);

  final CafeCoffeeListPageViewModel viewModel;

  @override
  _CafeCoffeeListTileState createState() => _CafeCoffeeListTileState();
}

class _CafeCoffeeListTileState extends State<_CafeCoffeeListTile> {
  CafeCoffee coffee;

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
      // 挙動がおかしかったら、ここを変更する。
      information: coffee,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) =>
                Provider.value(
                  value: coffee,
                  child: CafeCoffeeDetailPage(),
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
