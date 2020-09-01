import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail_page/cafe_coffee_detail_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/detail_header.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../detail_page.dart';

class CafeCoffeeDetailPage extends StatefulWidget {
  @override
  _CafeCoffeeDetailPageState createState() => _CafeCoffeeDetailPageState();
}

class _CafeCoffeeDetailPageState extends State<CafeCoffeeDetailPage> {
  CafeCoffeeDetailPageViewModel viewModel;

  @override
  void initState() {
    viewModel = CafeCoffeeDetailPageViewModel(
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
            builder: (context, bool value, _) =>
                FavButton(
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
          valueListenable: viewModel.price,
          builder: (context, int value, _) =>
              IntListTile(
                title: const Text('値段'),
                unit: '円',
                value: value,
                onChanged: viewModel.priceChanged,
              ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.drinkDay,
          builder: (context, DateTime value, _) =>
              DateTimeListTile(
                title: const Text('飲んだ日'),
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
          title: const Text('カフェ'),
          onTap: () async {
            await viewModel.onDispose();

            final cafe = await context
                .read<CafeDao>()
                .fetchByUid(viewModel.coffee.cafeId);

            if (cafe == null) {
              await Fluttertoast.showToast(msg: 'そのカフェは削除されました');
              return;
            }
            await Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) =>
                    Provider.value(
                      value: cafe,
                      child: CafeDetailPage(),
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
