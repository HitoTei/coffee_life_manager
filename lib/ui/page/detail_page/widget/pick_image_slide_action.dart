import 'package:coffee_life_manager/function/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

class PickImageSlideAction extends StatelessWidget {
  const PickImageSlideAction(this.setImage);
  final Function(PickedFile) setImage;
  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
      caption: '画像を変更',
      icon: Icons.image,
      onTap: () async {
        removeFocus(context);
        final image = await await showDialog<Future<PickedFile>>(
          context: context,
          child: SimpleDialog(
            children: [
              FlatButton(
                child: const Text('ギャラリーから画像を選択'),
                onPressed: () async {
                  final image = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                  );

                  if (image != null) setImage(image);
                  Navigator.pop(context, image);
                },
              ),
              FlatButton(
                child: const Text('写真を撮影'),
                onPressed: () async {
                  final image = await ImagePicker().getImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) setImage(image);
                  Navigator.pop(context, image);
                },
              ),
            ],
          ),
        );
        if (image != null) {
          setImage(image);
        }
      },
    );
  }
}
