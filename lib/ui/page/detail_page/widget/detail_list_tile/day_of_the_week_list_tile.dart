import 'package:coffee_life_manager/entity/enums/day_of_the_week.dart';
import 'package:flutter/material.dart';

class DayOfTheWeekListTile extends StatelessWidget {
  DayOfTheWeekListTile({
    @required this.title,
    @required this.value,
    @required this.onChanged,
  }) : checkList = [
          for (final day in DayOfTheWeek.values) value.contains(day),
        ];

  final Widget title;
  final List<DayOfTheWeek> value;
  final Function(List<DayOfTheWeek>) onChanged;
  final List<bool> checkList;

  String makeTitleStr() {
    if (!checkList.contains(true)) return '無し';

    var cnt = 0;
    var res = '';
    for (var i = 0; i < checkList.length; i++) {
      if (checkList[i]) {
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
      title: title,
      subtitle: Text(subTitle),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: title,
              content: SizedBox(
                width: 70,
                child: _DayOfTheWeekAlertDialogContent(checkList),
              ),
              actions: [
                FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    final res = [
                      for (var i = 0; i < checkList.length; i++)
                        if (checkList[i]) DayOfTheWeek.values[i]
                    ];
                    onChanged(res);
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
  const _DayOfTheWeekAlertDialogContent(this.values);

  final List<bool> values;

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
                () => widget.values[day.index] = !widget.values[day.index],
              );
            },
          ),
      ],
    );
  }
}
