import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/bean_dao_impl.dart';
import 'package:coffee_life_manager/repository/model/dao/house_coffee_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/house_coffee_detail_page/house_coffee_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeHouseCoffeePage extends StatelessWidget {
  const MakeHouseCoffeePage(this._bean);

  final Bean _bean;

  @override
  Widget build(BuildContext context) {
    final coffee = HouseCoffee()
      ..roast = _bean.roast
      ..beanName = _bean.beanName
      ..beanId = _bean.uid
      ..drinkDay = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(_bean.beanName),
      ),
      body: ListView(
        children: [
          Provider.value(
              value: _bean,
              child: _BeanAmountWidget((val) => coffee.numOfCups = val)),
          const Divider(),
          DripListTile(
            initialValue: coffee.drip,
            onChanged: (val) => coffee.drip = val,
          ),
          GrindListTile(
            initialValue: coffee.grind,
            onChanged: (val) => coffee.grind = val,
          ),
          FlatButton(
            child: const Text('決定'),
            onPressed: () {
              _bean.remainingAmount -= coffee.numOfCups * _bean.oneCupPerGram;
              BeanDaoImpl().update(_bean);
              HouseCoffeeDaoImpl()
                  .insert(coffee)
                  .then((value) => coffee.uid = value);

              Navigator.pushReplacement<dynamic, dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) {
                    return HouseCoffeeDetailPage(coffee);
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

class _BeanAmountWidget extends StatefulWidget {
  const _BeanAmountWidget(this.onChanged);

  @override
  __BeanAmountWidgetState createState() => __BeanAmountWidgetState();
  final Function(int) onChanged;
}

class __BeanAmountWidgetState extends State<_BeanAmountWidget> {
  int cup = 1;

  @override
  Widget build(BuildContext context) {
    final bean = Provider.of<Bean>(context);
    return Center(
      child: Row(
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_drop_up),
                onPressed: () {
                  if ((cup + 1) * bean.oneCupPerGram > bean.remainingAmount)
                    return;
                  setState(() => cup++);
                  widget.onChanged(cup);
                },
              ),
              Text('$cup杯(${cup * bean.oneCupPerGram}g)'),
              IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: () {
                  if (cup <= 1) return;
                  setState(() => cup--);
                  widget.onChanged(cup);
                },
              ),
            ],
          ),
          Text('残量: ${bean.remainingAmount - cup * bean.oneCupPerGram}g'),
        ],
      ),
    );
  }
}
