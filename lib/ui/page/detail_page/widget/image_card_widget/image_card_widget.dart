import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'changeable_image.dart';
import 'image_card_widget_viewmodel.dart';

class ImageCardWidget extends StatelessWidget {
  ImageCardWidget(
      {@required ImageCardInformation imageInformation, @required this.actions})
      : viewModel = ImageCardWidgetViewModel(information: imageInformation),
        _editingController = TextEditingController()
          ..text = imageInformation.getTitle();

  final ImageCardWidgetViewModel viewModel;
  final List<Widget> actions;
  final TextEditingController _editingController;

  @override
  Widget build(BuildContext context) {
    _editingController.addListener(
      () => viewModel.information.setTitle(_editingController.text),
    );

    return SliverAppBar(
      elevation: 5,
      expandedHeight: 250,
      actions: actions,
      pinned: true,
      title: SizedBox(
        child: TextField(
          decoration:
              const InputDecoration(fillColor: Colors.white30, filled: true),
          controller: _editingController,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Provider.value(
          value: viewModel,
          child: ChangeableImage(),
        ),
      ),
    );
  }
}
