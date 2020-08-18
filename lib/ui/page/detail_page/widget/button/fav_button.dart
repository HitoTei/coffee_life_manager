import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavButton extends StatefulWidget {
  FavButton({
    @required this.isFavorite,
    @required this.onChanged,
  });

  final bool isFavorite;
  final Function(bool) onChanged;

  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool value;

  @override
  void initState() {
    value = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        value ? Icons.favorite : Icons.favorite_border,
      ),
      onPressed: () {
        setState(() {
          value = !value;
        });
        widget.onChanged(value);
      },
    );
  }
}
