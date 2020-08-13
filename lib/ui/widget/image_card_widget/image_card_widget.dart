import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:coffee_life_manager/ui/widget/image_card_widget/image_card_widget_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'changeable_image.dart';

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

    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Provider.value(
                value: viewModel,
                child: ChangeableImage(),
              ),
              if (viewModel.information.getMessage() != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    color: Colors.black,
                    child: Text(
                      viewModel.information.getMessage(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: TextField(
                  controller: _editingController,
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
    );
  }
}
