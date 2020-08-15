import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/day_of_the_week_deatil_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CafeDetailPage extends StatelessWidget {
  const CafeDetailPage(this._cafe);

  final Cafe _cafe;

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: _cafe,
        actions: [
          FavButton(
            isFavorite: _cafe.isFavorite,
            onChanged: (val) => _cafe.isFavorite = val,
          ),
          IconButton(
            icon: const Icon(Icons.local_cafe),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      detailList: [
        // TODO: 住所
        // TODO: 営業時間
        DayOfTheWeekDetailListTile(
          title: const Text('定休日'),
          value: _cafe.regularHoliday,
        ),
      ],
      rate: null,
      links: [
        ListTile(
          title: const Text('飲んだコーヒー'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('購入したコーヒー豆'),
          onTap: () {},
        ),
      ],
      memo: Container(),
    );
  }
}
