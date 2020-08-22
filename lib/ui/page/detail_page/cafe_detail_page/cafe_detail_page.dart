import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_coffee_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_coffee_detail_page/cafe_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page_viewmodel.dart';
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
  CafeDetailPage(Cafe cafe)
      : viewModel = CafeDetailPageViewModel(cafe, CafeDaoImpl());
  final CafeDetailPageViewModel viewModel;

  @override
  _CafeDetailPageState createState() => _CafeDetailPageState();
}

class _CafeDetailPageState extends State<CafeDetailPage> {
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
        imageInformation: widget.viewModel.cafe,
        actions: [
          ValueListenableBuilder(
            valueListenable: widget.viewModel.isFavorite,
            builder: (context, bool value, _) => FavButton(
              value: value,
              onChanged: (val) {
                widget.viewModel.isFavorite.value = val;
                widget.viewModel.cafe.isFavorite = val;
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.local_cafe),
            onPressed: () {
              final coffee = CafeCoffee()
                ..cafeId = widget.viewModel.cafe.uid
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
            onPressed: widget.viewModel.share,
          ),
        ],
      ),
      detailList: [
        ListTile(
          title: const Text('営業時間'),
          subtitle: TimeRange(
            initialRange: TimeRangeResult(
                widget.viewModel.cafe.startTime, widget.viewModel.cafe.endTime),
            firstTime: const TimeOfDay(hour: 0, minute: 0),
            lastTime: const TimeOfDay(hour: 24, minute: 0),
            fromTitle: const Text('始業時間'),
            toTitle: const Text('終業時間'),
            timeStep: 10,
            timeBlock: 10,
            backgroundColor: Theme
                .of(context)
                .canvasColor,
            activeTextStyle: TextStyle(
              color:
              (Theme
                  .of(context)
                  .primaryColorBrightness == Brightness.dark)
                      ? Colors.white
                      : Colors.black,
            ),
            onRangeCompleted: (res) {
              widget.viewModel.cafe.startTime = res.start;
              widget.viewModel.cafe.endTime = res.end;
              if (widget.viewModel.cafe.startTime
                  .after(widget.viewModel.cafe.endTime)) {
                widget.viewModel.cafe.endTime = widget.viewModel.cafe.startTime;
                widget.viewModel.cafe.endTime.add(minutes: 10);
              }
            },
          ),
        ),
        const Divider(),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.regularHoliday,
          builder: (context, List<DayOfTheWeek> value, _) {
            return DayOfTheWeekListTile(
              title: const Text('定休日'),
              value: value,
              onChanged: (val) {
                widget.viewModel.regularHoliday.value = val;
                widget.viewModel.cafe.regularHoliday = val;
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.mapUrl,
          builder: (context, String value, _) =>
              MapListTile(
                title: const Text('場所'),
                value: value,
                onChanged: (val) {
                  widget.viewModel.mapUrl.value = val;
                  widget.viewModel.cafe.mapUrl = val;
                },
              ),
        ),
      ],
      rate: null,
      links: [
        ListTile(
          title: const Text('飲んだコーヒー'),
          onTap: () {
            final list = ValueNotifier<List<CafeCoffee>>(null);
            CafeCoffeeDaoImpl()
                .fetchByCafeId(widget.viewModel.cafe.uid)
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
      ],
      memo: Container(),
    );
  }
}
