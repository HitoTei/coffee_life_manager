import 'package:coffee_life_manager/entity/enums/roast.dart';
import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:flutter/material.dart';

class RoastListTile extends StatelessWidget {
  const RoastListTile({
    @required this.value,
    @required this.onChanged,
  });

  final Roast value;
  final void Function(Roast) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('焙煎'),
      subtitle: Text('${roastStr[value.index]}'),
      onTap: () async {
        removeFocus(context);
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
          onChanged(next);
        }
      },
    );
  }
}
