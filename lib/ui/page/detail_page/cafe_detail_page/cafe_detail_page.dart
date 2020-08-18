import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/day_of_the_week_deatil_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

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
        TimeRange(
          initialRange: TimeRangeResult(_cafe.startTime, _cafe.endTime),
          firstTime: const TimeOfDay(hour: 0, minute: 0),
          lastTime: const TimeOfDay(hour: 24, minute: 0),
          fromTitle: const Text('始業時間'),
          toTitle: const Text('終業時間'),
          timeStep: 10,
          timeBlock: 10,
          onRangeCompleted: (res) {
            _cafe.startTime = res.start;
            if (_cafe.startTime.after(_cafe.endTime)) {
              _cafe.endTime = _cafe.startTime;
              _cafe.endTime.add(minutes: 10);
            }
          },
        ),
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
