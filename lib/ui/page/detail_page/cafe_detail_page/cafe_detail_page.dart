import 'package:coffee_life_manager/model/cafe_coffee.dart';
import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/cafe_coffee_dao.dart';
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
  @override
  _CafeDetailPageState createState() => _CafeDetailPageState();
}

class _CafeDetailPageState extends State<CafeDetailPage> {
  CafeDetailPageViewModel viewModel;

  @override
  void initState() {
    viewModel = CafeDetailPageViewModel(
      context.read(),
      context.read(),
    )..onInitState();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      header: DetailHeader(
        imageInformation: viewModel.cafe,
        actions: [
          ValueListenableBuilder(
            valueListenable: viewModel.isFavorite,
            builder: (context, bool value, _) => FavButton(
              value: value,
              onChanged: viewModel.isFavoriteChanged,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.local_cafe),
            onPressed: () {
              final coffee = CafeCoffee()
                ..cafeId = viewModel.cafe.uid
                ..drinkDay = DateTime.now();

              Navigator.pushReplacement<dynamic, dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => Provider.value(
                    value: coffee,
                    child: CafeCoffeeDetailPage(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: viewModel.share,
          ),
        ],
      ),
      detailList: [
        ValueListenableBuilder(
          valueListenable: viewModel.startTime,
          builder: (context, TimeOfDay value, _) =>
              TimeOfDayListTile(
                title: '始業時間',
                value: value,
                onChanged: viewModel.startTimeChanged,
              ),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.endTime,
          builder: (context, TimeOfDay value, _) =>
              TimeOfDayListTile(
                title: '終業時間',
                value: value,
                onChanged: viewModel.endTimeChanged,
              ),
        ),
        const Divider(),
        ValueListenableBuilder(
          valueListenable: viewModel.regularHoliday,
          builder: (context, List<DayOfTheWeek> value, _) {
            return DayOfTheWeekListTile(
              title: const Text('定休日'),
              value: value,
              onChanged: viewModel.regularHolidayChanged,
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.mapUrl,
          builder: (context, String value, _) =>
              MapListTile(
                title: const Text('場所'),
                value: value,
                onChanged: viewModel.mapUrlChanged,
              ),
        ),
      ],
      rate: null,
      links: [
        ListTile(
          title: const Text('飲んだコーヒー'),
          onTap: () async {
            await viewModel.onDispose();
            final list = ValueNotifier<List<CafeCoffee>>(null)
              ..value = await context
                  .read<CafeCoffeeDao>()
                  .fetchByCafeId(viewModel.cafe.uid);

            await Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) =>
                    ValueListenableProvider.value(
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
