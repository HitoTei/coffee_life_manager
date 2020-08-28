import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'changeable_image.dart';
import 'image_card_widget_viewmodel.dart';

class DetailHeader extends StatelessWidget {
  DetailHeader(
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
    final backgroundColor = Theme.of(context).primaryColor.withAlpha(60);

    return SliverAppBar(
      elevation: 5,
      expandedHeight: 250,
      actions: [
        for (final action in actions)
          Container(
            color: backgroundColor,
            child: action,
          )
      ],
      pinned: true,
      title: TextField(
        decoration: InputDecoration(filled: true, fillColor: backgroundColor),
        controller: _editingController,
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Provider.value(
          value: viewModel,
          child: ChangeableImage(),
        ),
      ),
    );
  }
}
