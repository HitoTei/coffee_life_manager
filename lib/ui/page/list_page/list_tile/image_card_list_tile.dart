import 'dart:io';

import 'package:coffee_life_manager/dialog/show_delete_dialog.dart';
import 'package:coffee_life_manager/function/get_file.dart';
import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:coffee_life_manager/ui/page/detail_page/widget/button/fav_button.dart';
import 'package:coffee_life_manager/ui/page/list_page/list_tile/list_tile_viewmodel.dart';
import 'package:coffee_life_manager/ui/widget/local_image/local_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCardListTile extends StatelessWidget {
  const ImageCardListTile({
    @required this.information,
    @required this.gotoDetailPage,
    @required this.viewModel,
  });

  final ImageCardInformation information;
  final Future<void> Function() gotoDetailPage;
  final ListTileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final image = ValueNotifier<File>(null);
    _getLocalFile(image);

    return SizedBox(
      height: 180,
      child: InkWell(
        key: UniqueKey(),
        onTap: gotoDetailPage,
        onLongPress: () {
          showDeleteDialog(
            context,
            () => Provider.of<Function(dynamic)>(context, listen: false)
                .call(viewModel.getItem()),
          );
        },
        child: Card(
          child: Column(
            children: [
              _image(image),
              _info(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(ValueNotifier<File> image) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(height: 120),
      child: Stack(
        children: [
          ValueListenableProvider<File>.value(
            value: image,
            child: LocalImage(),
          ),
          if (information.getMessage() != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(2),
                color: Colors.black54,
                child: Text(
                  information.getMessage(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            information.getTitle(),
            overflow: TextOverflow.ellipsis,
          ),
          width: 200,
          margin: const EdgeInsets.all(2),
        ),
        ValueListenableBuilder(
          valueListenable: viewModel.getIsFavorite(),
          builder: (context, bool value, _) => FavButton(
            value: value,
            onChanged: viewModel.onFavChanged,
          ),
        ),
      ],
    );
  }

  Future<void> _getLocalFile(ValueNotifier<File> image) async {
    try {
      image.value = await getLocalFile(information.getImageUri());
    } catch (e) {
      image.value = null;
    }
  }
}
