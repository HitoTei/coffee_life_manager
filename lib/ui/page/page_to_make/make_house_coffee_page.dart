import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:coffee_life_manager/model/enums/grind.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:coffee_life_manager/ui/page/page_to_make/make_house_coffee_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeHouseCoffeePage extends StatelessWidget {
  MakeHouseCoffeePage(Bean bean)
      : viewModel = MakeHouseCoffeePageViewModel(
            bean, BeanDaoImpl(), HouseCoffeeDaoImpl());
  final MakeHouseCoffeePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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
                    return HouseCoffeeDetailPage(viewModel.coffee);
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
    return Center(
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.arrow_drop_up),
              onPressed: viewModel.cupIncrement),
          Column(
            children: [
              IntListTile(
                title: Text('$cup杯(${cup * viewModel.bean.oneCupPerGram}g)'),
                unit: 'g (残量)',
                value: viewModel.bean.remainingAmount -
                    cup * viewModel.bean.oneCupPerGram,
                onChanged: viewModel.cupChanged,
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.arrow_drop_down),
            onPressed: viewModel.cupDecrement,
          ),
        ],
      ),
    );
  }
}
