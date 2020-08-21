import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:flutter/material.dart';

class DripListTile extends StatefulWidget {
  const DripListTile({
    @required this.initialValue,
    @required this.onChanged,
  });

  final Drip initialValue;
  final void Function(Drip) onChanged;

  @override
  _DripListTileState createState() => _DripListTileState();
}

class _DripListTileState extends State<DripListTile> {
  Drip value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('淹れ方'),
      subtitle: Text('${dripStr[value.index]}'),
      onTap: () async {
        final next = await showMenu<Drip>(
          context: context,
          position: RelativeRect.fill,
          initialValue: value,
          semanticLabel: '淹れ方',
          items: [
            for (final drip in Drip.values)
              PopupMenuItem(
                value: drip,
                child: Text(dripStr[drip.index]),
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
