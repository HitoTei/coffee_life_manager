import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../detail_page.dart';

class CafeCoffeeDetailPage extends StatefulWidget {
  const CafeCoffeeDetailPage(this._coffee);

  final CafeCoffee _coffee;

  @override
  _CafeCoffeeDetailPageState createState() => _CafeCoffeeDetailPageState();
}

class _CafeCoffeeDetailPageState extends State<CafeCoffeeDetailPage> {
  @override
  void dispose() {
    CafeCoffeeDaoImpl()
        .insert(widget._coffee)
        .then((value) => widget._coffee.uid = value);
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
          title: const Text('値段'),
          unit: '円',
          initialValue: widget._coffee.price,
          onChanged: (val) => widget._coffee.price = val,
        ),
        DetailDateTimeListTile(
          title: const Text('飲んだ日'),
          initialValue: widget._coffee.drinkDay,
          onChanged: (val) => widget._coffee.drinkDay,
        ),
      ],
      rate: RateWidget(
        widget._coffee.rate,
      ),
      links: [
        ListTile(
          title: const Text('カフェ'),
          onTap: () async {
            final cafe = await CafeDaoImpl().fetchByUid(widget._coffee.cafeId);
            await Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => CafeDetailPage(cafe),
              ),
            );
          },
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
