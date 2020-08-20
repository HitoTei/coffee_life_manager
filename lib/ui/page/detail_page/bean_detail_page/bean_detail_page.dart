import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list_page/cafe_list_page.dart';
import 'package:coffee_life_manager/ui/page/page_to_make/make_house_coffee_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BeanDetailPage extends StatefulWidget {
  const BeanDetailPage(this._bean);

  final Bean _bean;

  @override
  _BeanDetailPageState createState() => _BeanDetailPageState();
}

class _BeanDetailPageState extends State<BeanDetailPage> {
  @override
  void initState() {
    if (widget._bean.uid == null) {
      BeanDaoImpl()
          .insert(widget._bean)
          .then((value) => widget._bean.uid = value);
    }
    super.initState();
  }

  @override
  void dispose() {
    BeanDaoImpl()
        .insert(widget._bean)
        .then((value) => widget._bean.uid = value);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: widget._bean,
        actions: [
          FavButton(
            isFavorite: widget._bean.isFavorite,
            onChanged: (val) {
              widget._bean.isFavorite = val;
            },
          ),
          IconButton(
            icon: const Icon(Icons.local_cafe),
            onPressed: () {
              if (widget._bean.remainingAmount < widget._bean.oneCupPerGram) {
                Fluttertoast.showToast(msg: 'コーヒーの残量が足りません');
                return;
              }
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => MakeHouseCoffeePage(widget._bean),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      detailList: [
        DetailIntListTile(
          title: const Text('残量'),
          unit: 'g',
          initialValue: widget._bean.remainingAmount,
          onChanged: (val) {
            widget._bean.remainingAmount = val;
          },
        ),
        DetailIntListTile(
          title: const Text('一杯当たり'),
          unit: 'g',
          initialValue: widget._bean.oneCupPerGram,
          onChanged: (val) {
            widget._bean.oneCupPerGram = val;
          },
        ),
        DetailIntListTile(
          title: const Text('値段'),
          unit: '円',
          initialValue: widget._bean.price,
          onChanged: (val) {
            widget._bean.price = val;
          },
        ),
        RoastListTile(
          initialValue: widget._bean.roast,
          onChanged: (val) {
            widget._bean.roast = val;
          },
        ),
        DetailDateTimeListTile(
          title: const Text('賞味期限'),
          initialValue: widget._bean.freshnessDate,
          onChanged: (val) {
            // TODO: 賞味期限を変更できるダイアログの追加
          },
        ),
        DetailDateTimeListTile(
          title: const Text('開封日時'),
          initialValue: widget._bean.openTime,
          onChanged: (val) {
            widget._bean.openTime = val;
          },
        ),
      ],
      rate: RateWidget(widget._bean.rate),
      links: [
        ListTile(
          title: const Text('この豆で淹れたコーヒー'),
          onTap: () {
            final list = ValueNotifier<List<HouseCoffee>>(null);
            HouseCoffeeDaoImpl()
                .fetchByBeanId(widget._bean.uid)
                .then((value) => list.value = value);
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => ValueListenableProvider.value(
                  value: list,
                  child: CafeListPage(),
                ),
              ),
            );
          },
        ),
        ListTile(
          // なんか面倒なのでなくてもいいかも
          title: const Text('豆を購入した店'),
          onTap: () async {},
        ),
      ],
      memo: TextFormField(
        initialValue: widget._bean.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          widget._bean.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
