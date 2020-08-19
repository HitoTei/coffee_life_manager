import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/material.dart';

class BeanDetailPage extends StatefulWidget {
  const BeanDetailPage(this._bean);

  final Bean _bean;

  @override
  _BeanDetailPageState createState() => _BeanDetailPageState();
}

class _BeanDetailPageState extends State<BeanDetailPage> {
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
          IconButton(icon: const Icon(Icons.local_cafe), onPressed: () {}),
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
            // TODO: この豆で淹れたコーヒーリストへ飛ばす
          },
        ),
        ListTile(
          title: const Text('豆を購入した店'),
          onTap: () {
            // TODO: この豆を購入した店の詳細画面へ飛ぶ
          },
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
