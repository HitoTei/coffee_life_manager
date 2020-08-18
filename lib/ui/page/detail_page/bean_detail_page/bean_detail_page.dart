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
  BeanDetailPage(this.bean);

  final Bean bean;
  final _memoEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _memoEditingController.text = bean.memo;

    return DetailPage(
      header: ImageCardWidget(
        imageInformation: bean,
        actions: [
          FavButton(
            isFavorite: bean.isFavorite,
            onChanged: (val) {
              bean.isFavorite = val;
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
          initialValue: bean.remainingAmount,
          onChanged: (val) {
            bean.remainingAmount = val;
          },
        ),
        DetailIntListTile(
          title: const Text('一杯当たり'),
          unit: 'g',
          initialValue: bean.oneCupPerGram,
          onChanged: (val) {
            bean.oneCupPerGram = val;
          },
        ),
        DetailIntListTile(
          title: const Text('値段'),
          unit: '円',
          initialValue: bean.price,
          onChanged: (val) {
            bean.price = val;
          },
        ),
        RoastListTile(
          initialValue: bean.roast,
          onChanged: (val) {
            bean.roast = val;
          },
        ),
        DetailDateTimeListTile(
          title: const Text('賞味期限'),
          initialValue: bean.freshnessDate,
          onChanged: (val) {
            // TODO: 賞味期限を変更できるダイアログの追加
          },
        ),
        DetailDateTimeListTile(
          title: const Text('開封日時'),
          initialValue: bean.openTime,
          onChanged: (val) {
            bean.openTime = val;
          },
        ),
      ],
      rate: RateWidget(bean.rate),
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
      memo: TextField(
        controller: _memoEditingController,
        decoration: const InputDecoration(
          labelText: 'メモ',
        ),
        onChanged: (val) {
          bean.memo = val;
        },
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
