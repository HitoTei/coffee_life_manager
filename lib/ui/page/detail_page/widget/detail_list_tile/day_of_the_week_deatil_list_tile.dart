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

  String makeTitleStr() {
    if (!value.contains(true)) return '無し';

    var cnt = 0;
    var res = '';
    for (var i = 0; i < value.length; i++) {
      if (value[i]) {
        if (cnt != 0) res += '・';
        res += dayOfTheWeekStr[i];
        cnt++;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final subTitle = makeTitleStr();

    return ListTile(
      title: widget.title,
      subtitle: Text(subTitle),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: widget.title,
              content: _DayOfTheWeekAlertDialogContent(value, setState),
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

class _DayOfTheWeekAlertDialogContent extends StatefulWidget {
  const _DayOfTheWeekAlertDialogContent(this.values, this.parentSetState);

  final List<bool> values;
  final Function(Function()) parentSetState;

  @override
  __DayOfTheWeekAlertDialogContentState createState() =>
      __DayOfTheWeekAlertDialogContentState();
}

class __DayOfTheWeekAlertDialogContentState
    extends State<_DayOfTheWeekAlertDialogContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final day in DayOfTheWeek.values)
          CheckboxListTile(
            title: Text(dayOfTheWeekStr[day.index]),
            value: widget.values[day.index],
            onChanged: (val) {
              setState(
                () => widget.parentSetState(
                  () {
                    widget.values[day.index] = !widget.values[day.index];
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}
