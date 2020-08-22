import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  const FavButton({
    @required this.value,
    @required this.onChanged,
  });

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        value ? Icons.favorite : Icons.favorite_border,
      ),
      onPressed: () {
        onChanged(!value);
      },
    );
  }
}
