import 'package:coffee_life_manager/model/enums/day_of_the_week.dart';
import 'package:flutter/material.dart';

class DayOfTheWeekDetailListTile extends StatefulWidget {
  const DayOfTheWeekDetailListTile({
    @required this.title,
    @required this.value,
  });

  final Widget title;
  final List<DayOfTheWeek> value;

  @override
  _DayOfTheWeekDetailListTileState createState() =>
      _DayOfTheWeekDetailListTileState();
}

class _DayOfTheWeekDetailListTileState
    extends State<DayOfTheWeekDetailListTile> {
  List<bool> value;

  @override
  void initState() {
    super.initState();
    value = [
      for (final day in DayOfTheWeek.values) widget.value.contains(day),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var cnt = 0;
    final subTitle = (widget.value.isEmpty)
        ? '無し'
        : '${[
            for (var i = 0; i < value.length; i++)
              if (value[i]) dayOfTheWeekStr[i] + ((cnt++ != 0) ? '・' : ''),
          ]}';

    return ListTile(
      title: widget.title,
      subtitle: Text(subTitle),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: widget.title,
              content: ListView(
                children: [
                  for (final day in DayOfTheWeek.values)
                    CheckboxListTile(
                      title: Text(dayOfTheWeekStr[day.index]),
                      value: value[day.index],
                      onChanged: (val) {
                        value[day.index] = !value[day.index];
                      },
                    ),
                ],
              ),
              actions: [
                FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    final res = [
                      for (var i = 0; i < value.length; i++)
                        if (value[i]) DayOfTheWeek.values[i]
                    ];
                    widget.value.removeRange(0, widget.value.length);
                    widget.value.addAll(res);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
