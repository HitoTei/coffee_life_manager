import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeOfDayListTile extends StatelessWidget {
  const TimeOfDayListTile(
      {@required this.title, @required this.value, @required this.onChanged});

  final TimeOfDay value;
  final String title;
  final Function(TimeOfDay) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value.format(context)),
      onTap: () async {
        removeFocus(context);
        final nextVal = await showTimePicker(
          helpText: title,
          context: context,
          initialTime: value,
        );
        if (nextVal == null) return;
        onChanged(nextVal);
      },
    );
  }
}
