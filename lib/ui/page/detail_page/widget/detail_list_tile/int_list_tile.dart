import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntListTile extends StatelessWidget {
  const IntListTile({
    @required this.title,
    @required this.subtitle,
    @required this.value,
    @required this.onChanged,
    this.hintText = '',
    this.digit = 7,
  });

  final Text title;
  final Widget subtitle;
  final int value;
  final Function(int) onChanged;
  final String hintText;

  final int digit;

  @override
  Widget build(BuildContext context) {
    final _editingController = TextEditingController()..text = value.toString();
    return ListTile(
      title: title,
      subtitle: subtitle,
      onTap: () {
        removeFocus(context);
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: TextField(
                controller: _editingController,
                keyboardType: TextInputType.number,
                maxLength: digit,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: title.data,
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
