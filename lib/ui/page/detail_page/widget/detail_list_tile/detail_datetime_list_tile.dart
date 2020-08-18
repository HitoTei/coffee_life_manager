import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailDateTimeListTile extends StatefulWidget {
  const DetailDateTimeListTile({
    @required this.title,
    @required this.initialValue,
    @required this.onChanged,
  });

  final Widget title;
  final DateTime initialValue;
  final void Function(DateTime) onChanged;

  @override
  _DetailDateTimeListTileState createState() => _DetailDateTimeListTileState();
}

class _DetailDateTimeListTileState extends State<DetailDateTimeListTile> {
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
      subtitle: Text('${value}'),
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
