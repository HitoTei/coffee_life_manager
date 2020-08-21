import 'package:coffee_life_manager/model/enums/roast.dart';
import 'package:flutter/material.dart';

class RoastListTile extends StatefulWidget {
  const RoastListTile({
    @required this.initialValue,
    @required this.onChanged,
  });

  final Roast initialValue;
  final void Function(Roast) onChanged;

  @override
  _RoastListTileState createState() => _RoastListTileState();
}

class _RoastListTileState extends State<RoastListTile> {
  Roast value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('焙煎'),
      subtitle: Text('${roastStr[value.index]}'),
      onTap: () async {
        final next = await showMenu<Roast>(
          context: context,
          position: RelativeRect.fill,
          initialValue: value,
          semanticLabel: '焙煎',
          items: [
            for (final roast in Roast.values)
              PopupMenuItem(
                value: roast,
                child: Text(roastStr[roast.index]),
              ),
          ],
        );
        if (next != null) {
          setState(() {
            value = next;
          });
        }
      },
    );
  }
}
