import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeListTile extends StatelessWidget {
  const DateTimeListTile({
    @required this.title,
    @required this.value,
    @required this.onChanged,
  });

  final Widget title;
  final DateTime value;
  final Function(DateTime) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: Text('$value'),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
        );
        if (date != null) {
          onChanged(date);
        }
      },
    );
  }
}
