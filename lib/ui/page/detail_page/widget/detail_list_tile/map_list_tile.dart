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
        showDialog<void>(
            context: context,
            builder: (_) {
              return SimpleDialog(
                children: [
                  FlatButton(
                    child: const Text('場所を編集'),
                    onPressed: () =>
                        _showEditTextDialog(context, editingController),
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

  Future<void> _showEditTextDialog(
      BuildContext context, TextEditingController editingController) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: title,
          content: TextField(
            controller: editingController,
            decoration: const InputDecoration(
              hintText: '地名を入力',
            ),
          ),
          actions: [
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                editingController.text = value.toString();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                onChanged(editingController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
