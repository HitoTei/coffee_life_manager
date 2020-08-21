import 'package:coffee_life_manager/model/enums/grind.dart';
import 'package:flutter/material.dart';

class GrindListTile extends StatefulWidget {
  const GrindListTile({
    @required this.initialValue,
    @required this.onChanged,
  });

  final Grind initialValue;
  final void Function(Grind) onChanged;

  @override
  _GrindListTileState createState() => _GrindListTileState();
}

class _GrindListTileState extends State<GrindListTile> {
  Grind value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('挽き方'),
      subtitle: Text('${grindStr[value.index]}'),
      onTap: () async {
        final next = await showMenu<Grind>(
          context: context,
          position: RelativeRect.fill,
          initialValue: value,
          semanticLabel: '焙煎',
          items: [
            for (final grind in Grind.values)
              PopupMenuItem(
                value: grind,
                child: Text(grindStr[grind.index]),
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
