import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail_page/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/day_of_the_week_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/map_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list_page/cafe_coffee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_range/time_range.dart';

class CafeDetailPage extends StatefulWidget {
  const CafeDetailPage(this._cafe);

  final Cafe _cafe;

  @override
  _CafeDetailPageState createState() => _CafeDetailPageState();
}

class _CafeDetailPageState extends State<CafeDetailPage> {
  @override
  void initState() {
    CafeDaoImpl()
        .insert(widget._cafe)
        .then((value) => widget._cafe.uid = value);
    super.initState();
  }

  @override
  void dispose() {
    CafeDaoImpl()
        .insert(widget._cafe)
        .then((value) => widget._cafe.uid = value);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: widget._cafe,
        actions: [
          FavButton(
            isFavorite: widget._cafe.isFavorite,
            onChanged: (val) => widget._cafe.isFavorite = val,
          ),
          IconButton(
            icon: const Icon(Icons.local_cafe),
            onPressed: () {
              final coffee = CafeCoffee()
                ..cafeId = widget._cafe.uid
                ..drinkDay = DateTime.now();

              Navigator.pushReplacement<dynamic, dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => CafeCoffeeDetailPage(coffee),
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
        ListTile(
          title: const Text('営業時間'),
          subtitle: TimeRange(
            initialRange:
                TimeRangeResult(widget._cafe.startTime, widget._cafe.endTime),
            firstTime: const TimeOfDay(hour: 0, minute: 0),
            lastTime: const TimeOfDay(hour: 24, minute: 0),
            fromTitle: const Text('始業時間'),
            toTitle: const Text('終業時間'),
            timeStep: 10,
            timeBlock: 10,
            onRangeCompleted: (res) {
              widget._cafe.startTime = res.start;
              if (widget._cafe.startTime.after(widget._cafe.endTime)) {
                widget._cafe.endTime = widget._cafe.startTime;
                widget._cafe.endTime.add(minutes: 10);
              }
            },
          ),
        ),
        const Divider(),
        DayOfTheWeekListTile(
          title: const Text('定休日'),
          value: widget._cafe.regularHoliday,
        ),
        MapListTile(
          title: const Text('場所'),
          initialValue: widget._cafe.mapUrl,
          onChanged: (val) => widget._cafe.mapUrl = val,
        ),
      ],
      rate: null,
      links: [
        ListTile(
          title: const Text('飲んだコーヒー'),
          onTap: () {
            final list = ValueNotifier<List<CafeCoffee>>(null);
            CafeCoffeeDaoImpl()
                .fetchByCafeId(widget._cafe.uid)
                .then((value) => list.value = value);
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => ValueListenableProvider.value(
                  value: list,
                  child: CafeCoffeeListPage(),
                ),
              ),
            );
          },
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
