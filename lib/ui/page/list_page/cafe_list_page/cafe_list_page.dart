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

    return Scaffold(
      body: ListView(
        children: [
          for (final cafe in cafeList)
            InkWell(
              onLongPress: () {
                Provider.of<Function(dynamic)>(context).call(cafe);
              },
              child: CafeListTile(cafe, viewModel),
            ),
        ],
      ),
    );
  }
}

class CafeListTile extends StatefulWidget {
  const CafeListTile(this.cafe, this.viewModel);

  final Cafe cafe;
  final CafeListPageViewModel viewModel;

  @override
  _CafeListTileState createState() => _CafeListTileState();
}

class _CafeListTileState extends State<CafeListTile> {
  Cafe cafe;

  @override
  void initState() {
    cafe = widget.cafe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      actions: [
        FavButton(
          isFavorite: widget.cafe.isFavorite,
          onChanged: (val) {
            widget.cafe.isFavorite = val;
            widget.viewModel.onFavChanged(widget.cafe);
          },
        ),
      ],

      // 挙動がおかしかったら、ここを変更する。
      information: widget.cafe,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => CafeDetailPage(widget.cafe),
          ),
        );
        setState(() {
          cafe = widget.cafe;
        });
      },
    );
  }
}
