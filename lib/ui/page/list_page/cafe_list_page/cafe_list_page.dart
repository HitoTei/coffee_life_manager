import 'package:coffee_life_manager/dialog/show_delete_dialog.dart';
import 'package:coffee_life_manager/model/cafe.dart';
import 'package:coffee_life_manager/repository/model/dao/cafe_dao_impl.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/widget/list_tile/image_card_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cafe_list_page_viewmodel.dart';

class CafeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cafeList = Provider.of<List<Cafe>>(context);
    final viewModel = CafeListPageViewModel(CafeDaoImpl());

    if (cafeList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (cafeList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('要素がありません'),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          for (final cafe in cafeList)
            InkWell(
              key: UniqueKey(),
              onLongPress: () {
                showDeleteDialog(
                  context,
                  () => Provider.of<Function(dynamic)>(context, listen: false)
                      .call(cafe),
                );
              },
              child: Provider.value(
                value: cafe,
                child: CafeListTile(viewModel),
              ),
            ),
        ],
      ),
    );
  }
}

class CafeListTile extends StatefulWidget {
  const CafeListTile(this.viewModel);

  final CafeListPageViewModel viewModel;

  @override
  _CafeListTileState createState() => _CafeListTileState();
}

class _CafeListTileState extends State<CafeListTile> {
  Cafe cafe;

  @override
  void initState() {
    cafe = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      actions: [
        FavButton(
          value: cafe.isFavorite,
          onChanged: (val) {
            setState(() {
              cafe.isFavorite = val;
              widget.viewModel.onFavChanged(cafe);
            });
          },
        ),
      ],
      information: cafe,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => Provider.value(
              value: cafe,
              child: CafeDetailPage(),
            ),
          ),
        );
        setState(() {
          cafe = cafe;
        });
      },
    );
  }
}
