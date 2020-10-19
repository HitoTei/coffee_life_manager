import 'dart:io';

import 'package:coffee_life_manager/function/files.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListPageSlidable extends StatelessWidget {
  const ListPageSlidable({
    @required this.child,
    @required this.slidableKey,
    @required this.removeFromRepository,
    @required this.undoDelete,
    @required this.goDetailPage,
    @required this.imageUri,
  });

  final Widget child;
  final Key slidableKey;
  final Function() removeFromRepository;
  final Function() undoDelete;
  final Function() goDetailPage;
  final String imageUri;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goDetailPage,
      child: Dismissible(
        key: slidableKey,
        child: child,
        onDismissed: (_) async {
          final path = (await getApplicationDocumentsDirectory()).path;
          if (imageUri != null && imageUri.isNotEmpty) {
            await File('$path/$imageUri').copy('$path/cache');
          }
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text('削除しました'),
                action: SnackBarAction(
                  label: '元に戻す',
                  onPressed: () async {
                    if (imageUri != null && imageUri.isNotEmpty) {
                      final file = await getLocalFile('cache');
                      await file.copy('$path/$imageUri');
                    }
                    undoDelete();
                  },
                ),
              ),
            );

          removeFromRepository();
        },
      ),
    );
  }
}

class ListPageTile extends StatelessWidget {
  const ListPageTile(this.child, this.gotoDetailPage);
  final Widget child;
  final Function() gotoDetailPage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: gotoDetailPage,
      child: child,
    );
  }
}
