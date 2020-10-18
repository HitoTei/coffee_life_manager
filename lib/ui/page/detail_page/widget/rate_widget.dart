import 'package:coffee_life_manager/entity/rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final rateState = ScopedProvider<List<int>>((_) => null);
final rateStateUpdater = ScopedProvider<Function(List<int>)>((_) => null);

class RateWidget extends StatelessWidget {
  const RateWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          _RateItem(
            title: bitternessDisplayString,
            rateKey: bitternessKey,
            index: 0,
          ),
          _RateItem(
            title: sournessDisplayString,
            rateKey: sournessKey,
            index: 1,
          ),
          _RateItem(
            title: fragranceDisplayString,
            rateKey: fragranceKey,
            index: 2,
          ),
          _RateItem(
            title: richDisplayString,
            rateKey: richKey,
            index: 3,
          ),
          _RateItem(
            title: overallDisplayString,
            rateKey: overallKey,
            index: 4,
          ),
        ],
      ),
    );
  }
}

class _RateItem extends ConsumerWidget {
  const _RateItem({
    @required this.title,
    @required this.rateKey,
    @required this.index,
  });

  final String title;
  final String rateKey;
  final int index;

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final state = watch(rateState);
    final update = watch(rateStateUpdater);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              Expanded(
                child: IconButton(
                  tooltip: '$title を ${i + 1}点に変更',
                  icon: (i <= state[index])
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border),
                  onPressed: () => update(
                    state..[index] = i,
                  ),
                  key: Key('$rateKey$i'),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
