import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:coffee_life_manager/model/enums/grind.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/page_to_make/make_house_coffee_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeHouseCoffeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = MakeHouseCoffeePageViewModel(
      Provider.of(context, listen: false),
      Provider.of(context, listen: false),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.bean.beanName),
      ),
      body: ListView(
        children: [
          MultiProvider(
            providers: [
              Provider.value(value: viewModel),
              ValueListenableProvider.value(value: viewModel.cup),
            ],
            child: _BeanAmountWidget(),
          ),
          const Divider(),
          ValueListenableBuilder(
            valueListenable: viewModel.drip,
            builder: (context, Drip value, _) => DripListTile(
              value: value,
              onChanged: viewModel.dripChanged,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: viewModel.grind,
            builder: (context, Grind value, _) => GrindListTile(
              value: value,
              onChanged: viewModel.grindChanged,
            ),
          ),
          FlatButton(
            child: const Text('決定'),
            onPressed: () {
              viewModel.save();
              Navigator.pushReplacement<dynamic, dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) {
                    return Provider.value(
                      value: viewModel.coffee,
                      child: HouseCoffeeDetailPage(),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BeanAmountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MakeHouseCoffeePageViewModel>(context);
    final cup = Provider.of<int>(context);

    final beanAmount = cup * viewModel.bean.oneCupPerGram;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.arrow_drop_up),
                onPressed: viewModel.cupIncrement,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(
                  '使用できる豆の量 ${viewModel.bean.remainingAmount} g ',
                ),
                subtitle: Text('使用する豆の量 $beanAmount'),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: viewModel.cupDecrement,
              ),
            ),
          ],
        ),
        IntListTile(
          title: Text(
            '淹れる量 $cup杯',
          ),
          unit: '杯',
          hintText:
              '最大: ${(viewModel.bean.remainingAmount / viewModel.bean.oneCupPerGram).toInt()}杯',
          value: cup,
          onChanged: (val) {
            if (!viewModel.cupChanged(val)) {
              Scaffold.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    '豆の量が足りません',
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
