import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapListTile extends StatelessWidget {
  const MapListTile({
    @required this.title,
    @required this.value,
    @required this.onChanged,
  });

  final Widget title;
  final String value;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final editingController = TextEditingController()..text = value;
    return ListTile(
      title: title,
      subtitle: Text('$value'),
      onTap: () {
        removeFocus(context);
        showDialog<void>(
            context: context,
            builder: (_) {
              return SimpleDialog(
                children: [
                  FlatButton(
                    child: const Text('場所を編集'),
                    onPressed: () => showEditTextDialog(
                      context,
                      editingController,
                      onChanged: onChanged,
                      title: const Text('地名を入力'),
                      initialValue: value,
                    ),
                  ),
                  FlatButton(
                    child: const Text('マップへ移動'),
                    onPressed: () {
                      MapsLauncher.launchQuery(value);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}

Future<void> showEditTextDialog(
    BuildContext context, TextEditingController editingController,
    {@required Function(String) onChanged,
    @required Widget title,
    @required String initialValue,
    @required String hintText}) {
  return showDialog<void>(
    context: context,
    builder: (_) {
      final input = TextField(
        controller: editingController,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      );
      final cancel = FlatButton(
        child: const Text('Cancel'),
        onPressed: () {
          editingController.text = initialValue.toString();
          Navigator.pop(context);
        },
      );
      final ok = FlatButton(
        child: const Text('Ok'),
        onPressed: () {
          onChanged(editingController.text);
          Navigator.pop(context);
        },
      );
      return OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return AlertDialog(
              title: title,
              content: input,
              actions: [
                cancel,
                ok,
              ],
            );
          } else {
            return Scaffold(
              body: Column(
                children: [
                  title,
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: input,
                      ),
                      SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ok,
                            cancel,
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        },
      );
    },
  );
}
