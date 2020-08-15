import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_datetime_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/detail_int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/roast_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget.dart';
import 'package:flutter/material.dart';

class BeanDetailPage extends StatelessWidget {
  const BeanDetailPage(this._bean);

  final Bean _bean;

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: _bean,
        actions: [
          FavButton(
            isFavorite: _bean.isFavorite,
            onChanged: (val) {
              _bean.isFavorite = val;
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
          initialValue: _bean.remainingAmount,
          onChanged: (val) {
            _bean.remainingAmount = val;
          },
        ),
        DetailIntListTile(
          title: const Text('一杯当たり'),
          unit: 'g',
          initialValue: _bean.oneCupPerGram,
          onChanged: (val) {
            _bean.oneCupPerGram = val;
          },
        ),
        DetailIntListTile(
          title: const Text('値段'),
          unit: '円',
          initialValue: _bean.price,
          onChanged: (val) {
            _bean.price = val;
          },
        ),
        RoastListTile(
          initialValue: _bean.roast,
          onChanged: (val) {
            _bean.roast = val;
          },
        ),
        DetailDateTimeListTile(
          title: const Text('賞味期限'),
          initialValue: _bean.freshnessDate,
          onChanged: (val) {
            // TODO: 賞味期限を変更できるダイアログの追加
          },
        ),
        DetailDateTimeListTile(
          title: const Text('開封日時'),
          initialValue: _bean.openTime,
          onChanged: (val) {
            _bean.openTime = val;
          },
        ),
      ],
      rate: RateWidget(_bean.rate),
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
        initialValue: _bean.memo,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          _bean.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
