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

  final Widget title;
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
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: title,
              content: TextField(
                controller: _editingController,
                keyboardType: TextInputType.number,
                maxLength: digit,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  hintText: hintText,
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
