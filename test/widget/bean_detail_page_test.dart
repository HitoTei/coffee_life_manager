import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/model/house_coffee.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:coffee_life_manager/repository/model/dao/interface/house_coffee_dao.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/image_card_widget/detail_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class _BeanDao implements BeanDao {
  @override
  Future<int> delete(Bean bean) {}

  @override
  Future<List<Bean>> fetchAll() async {
    return <Bean>[];
  }

  @override
  Future<List<Bean>> fetchByCafeId(int cafeId) {
    return null;
  }

  @override
  Future<Bean> fetchByUid(int uid) {
    return null;
  }

  @override
  Future<List<Bean>> fetchFavorite() async {
    return [];
  }

  @override
  Future<int> insert(Bean bean) async {
    return 0;
  }

  @override
  Future<int> update(Bean bean) {
    return null;
  }
}

class _HouseCoffeeDao implements HouseCoffeeDao {
  @override
  Future<int> delete(HouseCoffee coffee) {
    return null;
  }

  @override
  Future<List<HouseCoffee>> fetchAll() {
    return null;
  }

  @override
  Future<List<HouseCoffee>> fetchByBeanId(int id) {
    return null;
  }

  @override
  Future<HouseCoffee> fetchByUid(int uid) {
    return null;
  }

  @override
  Future<List<HouseCoffee>> fetchFavorite() {
    return null;
  }

  @override
  Future<int> insert(HouseCoffee coffee) {
    return null;
  }

  @override
  Future<int> update(HouseCoffee coffee) {
    return null;
  }
}

void main() {
  testWidgets('bean detail page layout test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              Provider.value(value: Bean()),
              Provider<BeanDao>.value(value: _BeanDao()),
              Provider<HouseCoffeeDao>.value(value: _HouseCoffeeDao()),
            ],
            child: BeanDetailPage(),
          ),
        ),
      ),
    );

    expect(find.byType(DetailHeader), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.local_cafe), findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);
  });
}
