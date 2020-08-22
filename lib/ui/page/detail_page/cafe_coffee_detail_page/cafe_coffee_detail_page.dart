import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail_page/cafe_coffee_detail_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../detail_page.dart';

class CafeCoffeeDetailPage extends StatefulWidget {
  CafeCoffeeDetailPage(CafeCoffee coffee)
      : viewModel = CafeCoffeeDetailPageViewModel(coffee, CafeCoffeeDaoImpl());

  final CafeCoffeeDetailPageViewModel viewModel;

  @override
  _CafeCoffeeDetailPageState createState() => _CafeCoffeeDetailPageState();
}

class _CafeCoffeeDetailPageState extends State<CafeCoffeeDetailPage> {
  @override
  void initState() {
    widget.viewModel.onInitState();
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: widget.viewModel.coffee,
        actions: [
          ValueListenableBuilder(
            valueListenable: widget.viewModel.isFavorite,
            builder: (context, bool value, _) => FavButton(
              value: value,
              onChanged: (val) {
                widget.viewModel.isFavorite.value = val;
                widget.viewModel.coffee.isFavorite = val;
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: widget.viewModel.share,
          ),
        ],
      ),
      detailList: [
        ValueListenableBuilder(
          valueListenable: widget.viewModel.price,
          builder: (context, int value, _) => IntListTile(
            title: const Text('値段'),
            unit: '円',
            value: value,
            onChanged: (val) {
              widget.viewModel.price.value = val;
              widget.viewModel.coffee.price = val;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.drinkDay,
          builder: (context, DateTime value, _) => DateTimeListTile(
            title: const Text('飲んだ日'),
            value: value,
            onChanged: (val) {
              widget.viewModel.drinkDay.value = value;
              widget.viewModel.coffee.drinkDay = value;
            },
          ),
        ),
      ],
      rate: RateWidget(
        widget.viewModel.coffee.rate,
      ),
      links: [
        ListTile(
          title: const Text('カフェ'),
          onTap: () async {
            final cafe =
                await CafeDaoImpl().fetchByUid(widget.viewModel.coffee.cafeId);
            if (cafe == null) {
              await Fluttertoast.showToast(msg: 'そのカフェは削除されました');
              return;
            }
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
        initialValue: widget.viewModel.coffee.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          widget.viewModel.coffee.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
