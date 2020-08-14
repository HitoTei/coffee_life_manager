import 'package:coffee_life_manager/model/bean.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/widget/image_card_widget/image_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('bean detail page layout test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BeanDetailPage(Bean()),
        ),
      ),
    );

    expect(find.byType(ImageCardWidget), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.local_cafe), findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);
  });
}
