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
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    _getLocalFile(image);

    return InkWell(
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
        child: isPortrait
            ? Column(
                children: [
                  Stack(
                    children: [
                      _image(image, isPortrait),
                      _message(isPortrait),
                    ],
                  ),
                  _info(context),
                ],
              )
            : Row(
                children: [
                  _image(image, isPortrait),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _info(context),
                        _message(isPortrait),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _image(ValueNotifier<File> image, bool isPortrait) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(
        height: 120,
        width: !isPortrait ? 200 : null,
      ),
      child: ValueListenableProvider<File>.value(
        value: image,
        child: LocalImage(),
      ),
    );
  }

  Widget _message(bool isPortrait) {
    if (information.getMessage() != null) {
      if (isPortrait) {
        return Align(
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
        );
      } else {
        return Text(
          information.getMessage(),
        );
      }
    } else {
      return Container();
    }
  }

  Widget _info(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            information.getTitle(),
            overflow: TextOverflow.ellipsis,
          ),
          width: MediaQuery.of(context).size.width - 280,
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
