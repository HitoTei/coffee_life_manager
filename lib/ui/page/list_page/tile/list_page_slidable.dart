import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListPageSlidable extends StatelessWidget {
  const ListPageSlidable({
    @required this.child,
    @required this.slidableKey,
    @required this.removeFromList,
    @required this.removeFromRepository,
    @required this.undoDelete,
    @required this.goDetailPage,
  });

  final Widget child;
  final Key slidableKey;
  final Function() removeFromList;
  final Function() removeFromRepository;
  final Function() undoDelete;
  final Function() goDetailPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goDetailPage,
      child: Slidable(
        key: slidableKey,
        secondaryActions: [
          IconSlideAction(
            icon: Icons.delete,
            caption: '削除する',
            color: Colors.red,
            onTap: () {
              removeFromList();
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: const Text('削除しました'),
                    action: SnackBarAction(
                      label: '元に戻す',
                      onPressed: undoDelete,
                    ),
                  ),
                ).closed.then(
                  (value) {
                    if (value != SnackBarClosedReason.action) {
                      removeFromRepository();
                    }
                  },
                );
            },
          ),
        ],
        actionPane: const SlidableDrawerActionPane(),
        child: child,
      ),
    );
  }
}
