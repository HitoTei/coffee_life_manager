import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:coffee_life_manager/model/enums/grind.dart';
import 'package:coffee_life_manager/model/enums/roast.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/detail_header.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../detail_page.dart';

class HouseCoffeeDetailPage extends StatefulWidget {
  @override
  _HouseCoffeeDetailPageState createState() => _HouseCoffeeDetailPageState();
}

class _HouseCoffeeDetailPageState extends State<HouseCoffeeDetailPage> {
  HouseCoffeeDetailPageViewModel viewModel;

  @override
  void initState() {
    viewModel = HouseCoffeeDetailPageViewModel(
      context.read(),
      context.read(),
    )..onInitState();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: viewModel.coffee,
        actions: [
          ValueListenableBuilder(
            valueListenable: viewModel.isFavorite,
            builder: (context, bool value, _) => FavButton(
              value: value,
              onChanged: viewModel.isFavoriteChanged,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: viewModel.share,
          ),
        ],
      ),
      detailList: [
        ValueListenableBuilder(
          valueListenable: viewModel.numOfCups,
          builder: (context, int value, _) => IntListTile(
            title: const Text('淹れた量'),
            unit: '杯',
            value: value,
            onChanged: viewModel.numOfCupsChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.grind,
          builder: (context, Grind value, _) => GrindListTile(
            value: value,
            onChanged: viewModel.grindChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.drip,
          builder: (context, Drip value, _) =>
              DripListTile(value: value, onChanged: viewModel.dripChanged),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.roast,
          builder: (context, Roast value, _) => RoastListTile(
            value: value,
            onChanged: viewModel.roastChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.drinkDay,
          builder: (context, DateTime value, _) => DateTimeListTile(
            title: const Text('淹れた日'),
            value: value,
            onChanged: viewModel.drinkDayChanged,
          ),
        ),
      ],
      rate: RateWidget(
        viewModel.coffee.rate,
      ),
      links: [
        ListTile(
          title: const Text('使用した豆'),
          onTap: () async {
            await viewModel.onDispose();
            final bean = await context
                .read<BeanDao>()
                .fetchByUid(viewModel.coffee.beanId);

            if (bean == null) {
              await Fluttertoast.showToast(msg: 'その豆は削除されました');
              return;
            }

            await Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => Provider.value(
                  value: bean,
                  child: BeanDetailPage(),
                ),
              ),
            );
          },
        ),
      ],
      memo: TextFormField(
        initialValue: viewModel.coffee.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          viewModel.coffee.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
