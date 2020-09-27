import 'package:coffee_life_manager/entity/enums/grind.dart';
import 'package:flutter/material.dart';

class GrindListTile extends StatelessWidget {
  const GrindListTile({
    @required this.value,
    @required this.onChanged,
  });

  final Grind value;
  final void Function(Grind) onChanged;

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
          onChanged(next);
        }
      },
    );
  }
}
