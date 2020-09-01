import 'package:coffee_life_manager/model/rate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'rate_widget_viewmodel.dart';

class RateWidget extends StatelessWidget {
  RateWidget(Rate rate) : _viewModel = RateWidgetViewModel(rate);
  final RateWidgetViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _viewModel,
      child: Container(
        child: Column(
          children: const [
            _RateItem(
              title: Rate.bitternessDisplayString,
              rateKey: Rate.bitternessKey,
            ),
            _RateItem(
              title: Rate.sournessDisplayString,
              rateKey: Rate.sournessKey,
            ),
            _RateItem(
              title: Rate.fragranceDisplayString,
              rateKey: Rate.fragranceKey,
            ),
            _RateItem(
              title: Rate.richDisplayString,
              rateKey: Rate.richKey,
            ),
            _RateItem(
              title: Rate.overallDisplayString,
              rateKey: Rate.overallKey,
            ),
          ],
        ),
      ),
    );
  }
}

class _RateItem extends StatefulWidget {
  const _RateItem({
    @required String title,
    @required String rateKey,
  })  : _rateKey = rateKey,
        _title = title;

  final String _rateKey, _title;

  @override
  __RateItemState createState() => __RateItemState();
}

class __RateItemState extends State<_RateItem> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RateWidgetViewModel>(context);
    return ListTile(
      title: Text(widget._title),
      subtitle: rateIcons(viewModel),
    );
  }

  Widget rateIcons(RateWidgetViewModel viewModel) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Expanded(
            child: IconButton(
              icon: (i <= viewModel.rate.values[widget._rateKey])
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
              onPressed: () => setState(
                () => viewModel.setValue(widget._rateKey, i),
              ),
              key: Key('${widget._rateKey}$i'),
            ),
          ),
      ],
    );
  }
}
