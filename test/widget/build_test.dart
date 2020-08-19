import 'package:coffee_life_manager/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('build test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
  });
}
