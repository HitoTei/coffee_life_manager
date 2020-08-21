import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeListTile extends StatefulWidget {
  const DateTimeListTile({
    @required this.title,
    @required this.initialValue,
    @required this.onChanged,
  });

  final Widget title;
  final DateTime initialValue;
  final void Function(DateTime) onChanged;

  @override
  _DateTimeListTileState createState() => _DateTimeListTileState();
}

class _DateTimeListTileState extends State<DateTimeListTile> {
  DateTime value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      subtitle: Text('$value'),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
        );
        if (date != null) {
          setState(() {
            value = date;
            widget.onChanged(value);
          });
        }
      },
    );
  }
}
