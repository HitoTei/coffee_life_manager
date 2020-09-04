import 'package:coffee_life_manager/dialog/show_delete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage(this.list, this.tile);

  final List<dynamic> list;
  final Widget Function(dynamic) tile;

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (list.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('要素がありません'),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          for (final item in list)
            InkWell(
              key: UniqueKey(),
              onLongPress: () {
                showDeleteDialog(
                  context,
                  () => Provider.of<Function(dynamic)>(context, listen: false)
                      .call(item),
                );
              },
              child: tile(item),
            ),
        ],
      ),
    );
  }
}
