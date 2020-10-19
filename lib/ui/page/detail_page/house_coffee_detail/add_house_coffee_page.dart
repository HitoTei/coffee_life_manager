import 'package:coffee_life_manager/constant_string.dart';
import 'package:coffee_life_manager/database/model/repository/entity_repository.dart';
import 'package:coffee_life_manager/entity/bean.dart';
import 'package:coffee_life_manager/entity/house_coffee.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/drip_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/grind_list_tile.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/detail_list_tile/int_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _controller = Provider.autoDispose(
  (ref) => AddHouseCoffeeController(ref.read),
);

final _bean = StateProvider.autoDispose<Bean>(
  (_) => null,
);
final _houseCoffee = StateProvider.autoDispose<HouseCoffee>(
  (_) => null,
);

class AddHouseCoffeePage extends ConsumerWidget {
  const AddHouseCoffeePage();
  static const routeName = '/addHouseCoffeePage';

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final map = ModalRoute.of(context).settings.arguments as Map<String, int>;
    context.read(_controller).init(map[beanIdKey]);

    return Scaffold(
      appBar: AppBar(
        title: Text('${watch(_bean)?.state?.beanName}を淹れる'),
      ),
      body: AddHouseCoffeeBody(),
    );
  }
}

class AddHouseCoffeeBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final bean = watch(_bean).state;
    final houseCoffee = watch(_houseCoffee).state;
    final controller = context.read(_controller);
    if (bean == null || houseCoffee == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    final amount = houseCoffee.numOfCups * bean.oneCupPerGram;
    return ListView(
      children: [
        ListTile(
          title: const Text('残りの豆の量'),
          subtitle: Text(
            '${bean.remainingAmount - amount}g',
            style: TextStyle(
              color: (bean.remainingAmount >= amount)
                  ? Theme.of(context).textTheme.bodyText1.color
                  : Theme.of(context).errorColor,
            ),
          ),
        ),
        IntListTile(
          title: Text('淹れる量(一杯${bean.oneCupPerGram}g)'),
          subtitle: Text('${houseCoffee.numOfCups}杯'),
          value: houseCoffee.numOfCups,
          onChanged: (val) {
            controller.updateHouseCoffee(
              houseCoffee.copyWith(numOfCups: val),
            );
          },
        ),
        GrindListTile(
          value: houseCoffee.grind,
          onChanged: (val) => controller.updateHouseCoffee(
            houseCoffee.copyWith(grind: val),
          ),
        ),
        DripListTile(
          value: houseCoffee.drip,
          onChanged: (val) => controller.updateHouseCoffee(
            houseCoffee.copyWith(drip: val),
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('完了'),
          onTap: () async {
            if (bean.remainingAmount >= amount) {
              final uid = await controller.save();
              Navigator.pop(
                context,
                {
                  'bean': bean.copyWith(
                      remainingAmount: bean.remainingAmount - amount),
                  uidKey: uid
                },
              );
            } else {
              await Fluttertoast.showToast(msg: '豆の量が足りません');
            }
          },
        )
      ],
    );
  }
}

class AddHouseCoffeeController {
  const AddHouseCoffeeController(this.read);
  final Reader read;
  Future<void> init(int beanId) async {
    read(_bean).state = await read(beanRepository).fetchByUid(beanId);
    read(_houseCoffee).state = HouseCoffee(
      beanId: beanId,
      roast: read(_bean).state.roast,
      drinkDay: DateTime.now(),
    );
  }

  Future<void> updateBean(Bean bean) async {
    read(_bean).state = bean;
  }

  Future<void> updateHouseCoffee(HouseCoffee houseCoffee) async {
    read(_houseCoffee).state = houseCoffee;
  }

  Future<int> save() async {
    await read(beanRepository).update(read(_bean).state);
    final uid = await read(houseCoffeeRepository).insert(
      read(_houseCoffee).state,
    );
    read(_houseCoffee).state = read(_houseCoffee).state.copyWith(uid: uid);
    return uid;
  }
}
