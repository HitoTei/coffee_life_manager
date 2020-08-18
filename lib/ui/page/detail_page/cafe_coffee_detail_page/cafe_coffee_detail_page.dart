import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../detail_page.dart';

class CafeCoffeeDetailPage extends StatelessWidget {
  const CafeCoffeeDetailPage(this._coffee);

  final CafeCoffee _coffee;

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
          title: const Text('値段'),
          unit: '円',
          initialValue: _coffee.price,
          onChanged: (val) => _coffee.price = val,
        ),
        DetailDateTimeListTile(
          title: const Text('飲んだ日'),
          initialValue: _coffee.drinkDay,
          onChanged: (val) => _coffee.drinkDay,
        ),
      ],
      rate: RateWidget(
        _coffee.rate,
      ),
      links: [
        ListTile(
          title: const Text('カフェ'),
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
