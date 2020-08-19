import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../detail_page.dart';

class HouseCoffeeDetailPage extends StatefulWidget {
  const HouseCoffeeDetailPage(this._coffee);

  final HouseCoffee _coffee;

  @override
  _HouseCoffeeDetailPageState createState() => _HouseCoffeeDetailPageState();
}

class _HouseCoffeeDetailPageState extends State<HouseCoffeeDetailPage> {
  @override
  void dispose() {
    HouseCoffeeDaoImpl().insert(widget._coffee);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: widget._coffee,
        actions: [
          FavButton(
            isFavorite: widget._coffee.isFavorite,
            onChanged: (val) => widget._coffee.isFavorite = val,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      detailList: [
        DetailIntListTile(
          title: const Text('淹れた量'),
          unit: '杯',
          initialValue: widget._coffee.numOfCups,
          onChanged: (val) => widget._coffee.numOfCups = val,
        ),
        GrindListTile(
          initialValue: widget._coffee.grind,
          onChanged: (val) => widget._coffee.grind = val,
        ),
        DripListTile(
          initialValue: widget._coffee.drip,
          onChanged: (val) => widget._coffee.drip = val,
        ),
        RoastListTile(
          initialValue: widget._coffee.roast,
          onChanged: (val) => widget._coffee.roast = val,
        ),
        DetailDateTimeListTile(
          title: const Text('淹れた日'),
          initialValue: widget._coffee.drinkDay,
          onChanged: (val) => widget._coffee.drinkDay,
        ),
      ],
      rate: RateWidget(
        widget._coffee.rate,
      ),
      links: [
        ListTile(
          title: const Text('使用した豆'),
          onTap: () {},
        ),
      ],
      memo: TextFormField(
        initialValue: widget._coffee.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          widget._coffee.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
