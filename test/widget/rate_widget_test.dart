import 'package:coffee_life_manager/model/rate.dart';
import 'package:coffee_life_manager/ui/widget/rate_widget/rate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'rate widget test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RateWidget(Rate()),
          ),
        ),
      );
      await tester.pump();

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byIcon(Icons.star_border), findsNWidgets(20));

      await tester.tap(find.byKey(const Key('${Rate.overallKey}4')));
      await tester.pump();

      expect(find.byIcon(Icons.star), findsNWidgets(9));
      expect(find.byIcon(Icons.star_border), findsNWidgets(16));

      for (var i = 0; i < 5; i++) {
        expect(
          ((tester.widget(find.byKey(Key('${Rate.overallKey}$i')).at(0))
                      as IconButton)
                  .icon as Icon)
              .icon,
          Icons.star,
        );
      }

      await tester.tap(find.byKey(const Key('${Rate.overallKey}0')));
      await tester.pump();
      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byIcon(Icons.star_border), findsNWidgets(20));

      for (var i = 0; i < 5; i++) {
        expect(
          ((tester.widget(find.byKey(Key('${Rate.overallKey}$i')).at(0))
                      as IconButton)
                  .icon as Icon)
              .icon,
          (i == 0) ? Icons.star : Icons.star_border,
        );
      }
    },
  );
}
