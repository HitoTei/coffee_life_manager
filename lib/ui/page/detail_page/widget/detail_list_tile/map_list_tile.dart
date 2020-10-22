import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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
      subtitle: value.isEmpty
          ? const Text('長押しでURLを設定')
          : Text(
              value,
              style: const TextStyle(color: Colors.lightBlue),
            ),
      onTap: () async {
        if (await canLaunch(value)) {
          await launch(value);
        } else {
          await Fluttertoast.showToast(msg: '無効なURLです\n長押しでURLを変更できます');
        }
      },
      onLongPress: () {
        showEditTextDialog(
          context,
          editingController,
          onChanged: onChanged,
          title: const Text('URLを入力'),
          initialValue: value,
          hintText: 'URLを入力',
        );
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
