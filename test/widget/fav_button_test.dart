import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('fav button test', (WidgetTester tester) async {
    var fav = false;
    final notifier = ValueNotifier(fav);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, bool value, _) => FavButton(
              value: value,
              onChanged: (val) {
                notifier.value = val;
                fav = val;
              },
            ),
          ),
        ),
      ),
    );
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(fav, true);
  });
}
