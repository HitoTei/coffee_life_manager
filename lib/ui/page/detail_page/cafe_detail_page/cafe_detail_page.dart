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
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/time_of_day_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/detail_header.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_coffee_list_page/cafe_coffee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              onChanged: widget.viewModel.isFavoriteChanged,
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
        ValueListenableBuilder(
          valueListenable: widget.viewModel.startTime,
          builder: (context, TimeOfDay value, _) => TimeOfDayListTile(
            title: '始業時間',
            value: value,
            onChanged: widget.viewModel.startTimeChanged,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.endTime,
          builder: (context, TimeOfDay value, _) => TimeOfDayListTile(
            title: '終業時間',
            value: value,
            onChanged: widget.viewModel.endTimeChanged,
          ),
        ),
        const Divider(),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.regularHoliday,
          builder: (context, List<DayOfTheWeek> value, _) {
            return DayOfTheWeekListTile(
              title: const Text('定休日'),
              value: value,
              onChanged: widget.viewModel.regularHolidayChanged,
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: widget.viewModel.mapUrl,
          builder: (context, String value, _) => MapListTile(
            title: const Text('場所'),
            value: value,
            onChanged: widget.viewModel.mapUrlChanged,
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
