import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/widget/rate_widget/rate_widget.dart';
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
          IconButton(
            icon: Icon(
                (bean.isFavorite) ? Icons.favorite : Icons.favorite_border),
            onPressed: () => bean.isFavorite = !bean.isFavorite,
          ),
          IconButton(icon: const Icon(Icons.local_cafe), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      detailList: [
        ListTile(
          title: const Text('残量'),
          subtitle: Text('${bean.remainingAmount}g'),
          onTap: () {
            // TODO: 値を変更できるダイアログの追加
          },
        ),
        ListTile(
          title: const Text('残り'),
          subtitle: Text('${bean.remainingAmount / bean.oneCupPerGram}杯'),
        ),
        ListTile(
          title: const Text('一杯当たり'),
          subtitle: Text('${bean.oneCupPerGram}g'),
          onTap: () {
            // TODO: 値を変更できるダイアログの追加
          },
        ),
        ListTile(
          title: const Text('値段'),
          subtitle: Text('${bean.price}'),
          onTap: () {
            // TODO: 値を変更できるダイアログの追加
          },
        ),
        ListTile(
          title: const Text('焙煎'),
          subtitle: Text('${bean.roast}'),
          onTap: () {
            // TODO: 焙煎度合いを選択できるダイアログの追加
          },
        ),
        ListTile(
          title: const Text('賞味期限'),
          subtitle: Text('${bean.freshnessDate}'),
          onTap: () {
            // TODO: 賞味期限を変更できるダイアログの追加
          },
        ),
        ListTile(
          title: const Text('開封日時'),
          subtitle: Text('${bean.openTime}'),
          onTap: () {
            // TODO: 開封日時を変更できるダイアログの追加
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
        maxLength: 50,
        maxLines: 5,
      ),
    );
  }
}
