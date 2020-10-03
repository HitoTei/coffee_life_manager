import 'package:coffee_life_manager/entity/enums/drip.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:flutter/material.dart';

class DripListTile extends StatelessWidget {
  const DripListTile({
    @required this.value,
    @required this.onChanged,
  });

  final Drip value;
  final Function(Drip) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('淹れ方'),
      subtitle: Text('${dripStr[value.index]}'),
      onTap: () async {
        removeFocus(context);
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
          onChanged(next);
        }
      },
    );
  }
}
