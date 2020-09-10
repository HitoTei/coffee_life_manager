import 'package:coffee_life_manager/repository/model/dao/interface/cafe_dao.dart';
import 'package:coffee_life_manager/ui/page/detail_page/cafe_detail_page/cafe_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/cafe_list_page/cafe_list_tile_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/image_card_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeListTile extends StatefulWidget {
  @override
  _CafeListTileState createState() => _CafeListTileState();
}

class _CafeListTileState extends State<CafeListTile> {
  CafeListTileViewModel viewModel;

  @override
  void initState() {
    viewModel = CafeListTileViewModel(
      context.read(),
      context.read(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      viewModel: viewModel,
      information: viewModel.cafe,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => Provider.value(
              value: viewModel.cafe,
              child: CafeDetailPage(),
            ),
          ),
        );

        final cafe =
            await context.read<CafeDao>().fetchByUid(viewModel.cafe.uid);

        setState(() {
          viewModel
            ..cafe = cafe
            ..onFavChanged(cafe.isFavorite);
        });
      },
    );
  }
}
