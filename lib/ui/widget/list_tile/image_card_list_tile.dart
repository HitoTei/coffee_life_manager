import 'dart:io';

import 'package:coffee_life_manager/function/get_file.dart';
import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:coffee_life_manager/ui/widget/local_image/local_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCardListTile extends StatelessWidget {
  const ImageCardListTile({
    @required this.information,
    @required this.actions,
    @required this.gotoDetailPage,
  });

  final ImageCardInformation information;
  final List<Widget> actions;
  final Future<void> Function() gotoDetailPage;

  @override
  Widget build(BuildContext context) {
    final image = ValueNotifier<File>(null);
    _getLocalFile(image);

    return SizedBox(
      height: 180,
      child: InkWell(
        onTap: gotoDetailPage,
        child: Card(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 120),
                child: Stack(
                  children: [
                    ValueListenableProvider<File>(
                      create: (_) => image,
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
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      information.getTitle(),
                    ),
                    width: 200,
                  ),
                  Row(
                    children: actions,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
