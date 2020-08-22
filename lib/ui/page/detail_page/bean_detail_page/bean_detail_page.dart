import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/enums/roast.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/house_coffee_list_page/house_coffee_list_page.dart';
import 'package:coffee_life_manager/ui/page/page_to_make/make_house_coffee_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BeanDetailPage extends StatefulWidget {
  BeanDetailPage(Bean bean)
      : viewModel = BeanDetailPageViewModel(bean, BeanDaoImpl());

  final BeanDetailPageViewModel viewModel;

  @override
  _BeanDetailPageState createState() => _BeanDetailPageState();
}

class _BeanDetailPageState extends State<BeanDetailPage> {
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
        imageInformation: widget.viewModel.bean,
        actions: [
          ValueListenableBuilder(
            valueListenable: widget.viewModel.isFavorite,
            builder: (context, bool value, _) => FavButton(
              value: value,
              onChanged: (val) {
                widget.viewModel.isFavorite.value = val;
                widget.viewModel.bean.isFavorite = val;
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.local_cafe),
            onPressed: () {
              if (widget.viewModel.canDripCoffee()) {
                Fluttertoast.showToast(msg: 'コーヒーの残量が足りません');
                return;
              }
              Navigator.pushReplacement<dynamic, dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => MakeHouseCoffeePage(widget.viewModel.bean),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: widget.viewModel.share,
          ),
        ],
      ),
      detailList: [
        ValueListenableBuilder(
          valueListenable: widget.viewModel.remainingAmount,
          builder: (context, int value, _) => IntListTile(
            title: const Text('残量'),
            unit: 'g',
            value: value,
            onChanged: (val) {
              widget.viewModel.remainingAmount.value = val;
              widget.viewModel.bean.remainingAmount = val;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.oneCupPerGram,
          builder: (context, int value, _) => IntListTile(
            title: const Text('一杯当たり'),
            unit: 'g',
            value: value,
            onChanged: (val) {
              widget.viewModel.oneCupPerGram.value = val;
              widget.viewModel.bean.oneCupPerGram = val;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.price,
          builder: (context, int value, _) => IntListTile(
            title: const Text('値段'),
            unit: '円',
            value: value,
            onChanged: (val) {
              widget.viewModel.price.value = val;
              widget.viewModel.bean.price = val;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.roast,
          builder: (context, Roast value, _) => RoastListTile(
            value: value,
            onChanged: (val) {
              widget.viewModel.roast.value = val;
              widget.viewModel.bean.roast = val;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.freshnessDate,
          builder: (context, DateTime value, _) => DateTimeListTile(
            title: const Text('賞味期限'),
            value: value,
            onChanged: (val) {
              widget.viewModel.freshnessDate.value = val;
              widget.viewModel.bean.freshnessDate = val;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.openTime,
          builder: (context, DateTime value, _) => DateTimeListTile(
            title: const Text('開封日時'),
            value: value,
            onChanged: (val) {
              widget.viewModel.openTime.value = val;
              widget.viewModel.bean.openTime = val;
            },
          ),
        ),
      ],
      rate: RateWidget(widget.viewModel.bean.rate),
      links: [
        ListTile(
          title: const Text('この豆で淹れたコーヒー'),
          onTap: () {
            final list = ValueNotifier<List<HouseCoffee>>(null);
            HouseCoffeeDaoImpl()
                .fetchByBeanId(widget.viewModel.bean.uid)
                .then((value) => list.value = value);
            Navigator.push<dynamic>(
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
        initialValue: widget.viewModel.bean.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          widget.viewModel.bean.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
