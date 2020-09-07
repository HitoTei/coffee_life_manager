import 'package:coffee_life_manager/model/enums/roast.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/detail_header.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list_page/house_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/page_to_make/make_house_coffee_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BeanDetailPage extends StatefulWidget {
  @override
  _BeanDetailPageState createState() => _BeanDetailPageState();
}

class _BeanDetailPageState extends State<BeanDetailPage> {
  BeanDetailPageViewModel viewModel;
  HouseCoffeeDao _dao;

  @override
  void initState() {
    viewModel = BeanDetailPageViewModel(
      context.read(),
      context.read(),
    )..onInitState();
    _dao = context.read();
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
        imageInformation: viewModel.bean,
        actions: [
          ValueListenableBuilder(
            valueListenable: viewModel.isFavorite,
            builder: (context, bool value, _) => FavButton(
              value: value,
              onChanged: viewModel.isFavoriteChanged,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.local_cafe),
            onPressed: () {
              if (viewModel.canDripCoffee()) {
                Fluttertoast.showToast(msg: 'コーヒーの残量が足りません');
                return;
              }
              Navigator.pushReplacement<dynamic, dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => Provider.value(
                    value: viewModel.bean,
                    child: MakeHouseCoffeePage(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: viewModel.share,
          ),
        ],
      ),
      detailList: [
        ValueListenableBuilder(
          valueListenable: viewModel.remainingAmount,
          builder: (context, int value, _) => IntListTile(
            title: const Text('残量'),
            unit: 'g',
            value: value,
            onChanged: viewModel.remainingAmountChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.oneCupPerGram,
          builder: (context, int value, _) => IntListTile(
            title: const Text('一杯当たり'),
            unit: 'g',
            value: value,
            onChanged: viewModel.oneCupPerGramChanged,
            digit: 2,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.price,
          builder: (context, int value, _) => IntListTile(
            title: const Text('値段'),
            unit: '円',
            value: value,
            onChanged: viewModel.priceChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.roast,
          builder: (context, Roast value, _) => RoastListTile(
            value: value,
            onChanged: viewModel.roastChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.freshnessDate,
          builder: (context, DateTime value, _) => DateTimeListTile(
            title: const Text('賞味期限'),
            value: value,
            onChanged: viewModel.freshnessDateChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.openTime,
          builder: (context, DateTime value, _) => DateTimeListTile(
            title: const Text('開封日時'),
            value: value,
            onChanged: viewModel.openTimeChanged,
          ),
        ),
      ],
      rate: RateWidget(viewModel.bean.rate),
      links: [
        ListTile(
          title: const Text('この豆で淹れたコーヒー'),
          onTap: () async {
            await viewModel.onDispose();
            final list = ValueNotifier<List<HouseCoffee>>(null)
              ..value = await _dao.fetchByBeanId(viewModel.bean.uid);

            await Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => ValueListenableProvider.value(
                  value: list,
                  child: HouseCoffeeListPage(),
                ),
              ),
            );
          },
        ),
      ],
      memo: TextFormField(
        initialValue: viewModel.bean.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          viewModel.bean.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
