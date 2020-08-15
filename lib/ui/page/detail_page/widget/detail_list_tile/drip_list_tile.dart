import 'package:coffee_life_manager/model/enums/drip.dart';
import 'package:flutter/material.dart';

class DripListTile extends StatefulWidget {
  const DripListTile({
    @required this.initialValue,
    @required this.onChanged,
  });

  final Drip initialValue;
  final void Function(Drip) onChanged;

  @override
  _DripListTileState createState() => _DripListTileState();
}

class _DripListTileState extends State<DripListTile> {
  Drip value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('挽き方'),
      subtitle: Text('${dripStr[value.index]}'),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return SimpleDialog(
              title: const Text('挽き方'),
              children: [
                for (final drip in Drip.values)
                  FlatButton(
                    child: Text(dripStr[drip.index]),
                    onPressed: () {
                      setState(() {
                        value = drip;
                      });
                      widget.onChanged(drip);
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
