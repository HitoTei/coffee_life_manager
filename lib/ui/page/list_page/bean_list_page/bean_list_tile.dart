import 'package:coffee_life_manager/repository/model/dao/interface/bean_dao.dart';
import 'package:coffee_life_manager/ui/page/detail_page/bean_detail_page/bean_detail_page.dart';
import 'package:coffee_life_manager/ui/page/list_page/bean_list_page/bean_list_tile_viewmodel.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/image_card_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeanListTile extends StatefulWidget {
  @override
  _BeanListTileState createState() => _BeanListTileState();
}

class _BeanListTileState extends State<BeanListTile> {
  BeanListTileViewModel viewModel;

  @override
  void initState() {
    viewModel = BeanListTileViewModel(
      context.read(),
      context.read(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ImageCardListTile(
      viewModel: viewModel,
      information: viewModel.bean,
      gotoDetailPage: () async {
        await Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => Provider.value(
              value: viewModel.bean,
              child: BeanDetailPage(),
            ),
          ),
        );
        final bean =
            await context.read<BeanDao>().fetchByUid(viewModel.bean.uid);
        setState(() {
          viewModel
            ..bean = bean
            ..onFavChanged(bean.isFavorite);
        });
      },
    );
  }
}
