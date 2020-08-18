import 'package:coffee_life_manager/model/house_coffee.dart';
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

class HouseCoffeeDetailPage extends StatelessWidget {
  const HouseCoffeeDetailPage(this._coffee);

  final HouseCoffee _coffee;

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: _coffee,
        actions: [
          FavButton(
            isFavorite: _coffee.isFavorite,
            onChanged: (val) => _coffee.isFavorite = val,
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
          initialValue: _coffee.numOfCups,
          onChanged: (val) => _coffee.numOfCups = val,
        ),
        GrindListTile(
          initialValue: _coffee.grind,
          onChanged: (val) => _coffee.grind = val,
        ),
        DripListTile(
          initialValue: _coffee.drip,
          onChanged: (val) => _coffee.drip = val,
        ),
        RoastListTile(
          initialValue: _coffee.roast,
          onChanged: (val) => _coffee.roast = val,
        ),
        DetailDateTimeListTile(
          title: const Text('淹れた日'),
          initialValue: _coffee.drinkDay,
          onChanged: (val) => _coffee.drinkDay,
        ),
      ],
      rate: RateWidget(
        _coffee.rate,
      ),
      links: [
        ListTile(
          title: const Text('使用した豆'),
          onTap: () {},
        ),
      ],
      memo: TextFormField(
        initialValue: _coffee.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          _coffee.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
