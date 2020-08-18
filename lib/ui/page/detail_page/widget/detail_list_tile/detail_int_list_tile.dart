import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailIntListTile extends StatefulWidget {
  const DetailIntListTile({
    @required this.title,
    @required this.unit,
    @required this.initialValue,
    @required this.onChanged,
  });

  final Widget title;
  final String unit;
  final int initialValue;
  final void Function(int) onChanged;

  @override
  _DetailIntListTileState createState() => _DetailIntListTileState();
}

class _DetailIntListTileState extends State<DetailIntListTile> {
  int value;
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
      subtitle: Text('$value${widget.unit}'),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: widget.title,
              content: TextField(
                controller: _editingController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  hintText: '正の整数を入力してください',
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
                      value = int.parse(_editingController.text);
                    });
                    widget.onChanged(value);
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
