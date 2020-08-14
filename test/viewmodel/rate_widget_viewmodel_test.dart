import 'package:coffee_life_manager/model/rate.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/rate_widget/rate_widget_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rate widget viewmodel test', () {
    final viewModel = RateWidgetViewModel(Rate());
    final rate = viewModel.rate;
    expect(rate.values[Rate.overallKey], 0);

    viewModel.setValue(Rate.overallKey, 4);
    expect(rate.values[Rate.overallKey], 4);

    viewModel.setValue(Rate.richKey, 100);
    expect(rate.values[Rate.richKey], 4);

    viewModel.setValue(Rate.richKey, -100);
    expect(rate.values[Rate.richKey], 0);
  });
}
