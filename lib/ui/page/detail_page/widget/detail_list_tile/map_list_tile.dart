import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapListTile extends StatefulWidget {
  const MapListTile({
    @required this.title,
    @required this.initialValue,
    @required this.onChanged,
  });

  final Widget title;
  final String initialValue;
  final void Function(String) onChanged;

  @override
  _MapListTileState createState() => _MapListTileState();
}

class _MapListTileState extends State<MapListTile> {
  String value;
  final _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    _editingController.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      subtitle: Text('$value'),
      onTap: () {
        showDialog<void>(
            context: context,
            builder: (_) {
              return SimpleDialog(
                children: [
                  FlatButton(
                    child: const Text('場所を編集'),
                    onPressed: _showEditTextDialog,
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

  Future<void> _showEditTextDialog() {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: widget.title,
          content: TextField(
            controller: _editingController,
            decoration: const InputDecoration(
              hintText: '地名を入力',
            ),
          ),
          actions: [
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                _editingController.text = value.toString();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                setState(() {
                  value = _editingController.text;
                });
                widget.onChanged(value);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
