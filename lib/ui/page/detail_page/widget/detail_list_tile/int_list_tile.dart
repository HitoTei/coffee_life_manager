import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntListTile extends StatelessWidget {
  IntListTile({
    @required this.title,
    @required this.unit,
    @required this.value,
    @required this.onChanged,
  }) : _editingController = TextEditingController()..text = value.toString();

  final Widget title;
  final String unit;
  final int value;
  final Function(int) onChanged;
  final TextEditingController _editingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: Text('$value$unit'),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: title,
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
                    onChanged(int.parse(_editingController.text));
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
