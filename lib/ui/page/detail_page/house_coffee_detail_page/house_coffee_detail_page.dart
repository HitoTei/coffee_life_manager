import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:coffee_life_manager/model/enums/grind.dart';
import 'package:coffee_life_manager/model/enums/roast.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../detail_page.dart';

class HouseCoffeeDetailPage extends StatefulWidget {
  HouseCoffeeDetailPage(HouseCoffee coffee)
      : viewModel =
            HouseCoffeeDetailPageViewModel(coffee, HouseCoffeeDaoImpl());
  final HouseCoffeeDetailPageViewModel viewModel;

  @override
  _HouseCoffeeDetailPageState createState() => _HouseCoffeeDetailPageState();
}

class _HouseCoffeeDetailPageState extends State<HouseCoffeeDetailPage> {
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
              onChanged: widget.viewModel.isFavoriteChanged,
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
          valueListenable: widget.viewModel.numOfCups,
          builder: (context, int value, _) => IntListTile(
            title: const Text('淹れた量'),
            unit: '杯',
            value: value,
            onChanged: widget.viewModel.numOfCupsChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.grind,
          builder: (context, Grind value, _) => GrindListTile(
            value: value,
            onChanged: widget.viewModel.grindChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.drip,
          builder: (context, Drip value, _) => DripListTile(
              value: value, onChanged: widget.viewModel.dripChanged),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.roast,
          builder: (context, Roast value, _) => RoastListTile(
            value: value,
            onChanged: widget.viewModel.roastChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.drinkDay,
          builder: (context, DateTime value, _) =>
              DateTimeListTile(
                title: const Text('淹れた日'),
                value: value,
                onChanged: widget.viewModel.drinkDayChanged,
              ),
        ),
      ],
      rate: RateWidget(
        widget.viewModel.coffee.rate,
      ),
      links: [
        ListTile(
          title: const Text('使用した豆'),
          onTap: () async {
            final bean =
            await BeanDaoImpl().fetchByUid(widget.viewModel.coffee.beanId);

            if (bean == null) {
              await Fluttertoast.showToast(msg: 'その豆は削除されました');
              return;
            }

            await Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => BeanDetailPage(bean),
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
