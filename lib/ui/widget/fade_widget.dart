import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final _opacity = StateProvider<double>((_) => 1);
final opacityController = Provider((ref) => OpacityController(ref.read));

class OpacityController {
  const OpacityController(this.read);
  final Reader read;

  Future<void> onPageUpdate() async {
    read(_opacity).state = 0;
    await Future<void>.delayed(const Duration(milliseconds: 250));
    read(_opacity).state = 1;
  }
}

class FadeWidget extends ConsumerWidget {
  const FadeWidget({@required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    return AnimatedOpacity(
      opacity: watch(_opacity).state,
      duration: watch(_opacity).state != 0
          ? const Duration(milliseconds: 250)
          : Duration.zero,
      child: child,
    );
  }
}
