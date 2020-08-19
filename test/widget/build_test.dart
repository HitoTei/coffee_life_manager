import 'package:coffee_life_manager/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('build test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
  });
}
