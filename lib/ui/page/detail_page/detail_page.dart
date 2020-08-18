import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(
      {@required this.header,
      @required this.detailList,
      @required this.rate,
      @required this.links,
      @required this.memo});

  final Widget header;
  final List<Widget> detailList;
  final Widget rate;
  final List<Widget> links;
  final Widget memo;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        header,
        SliverList(
          delegate: SliverChildListDelegate([
            for (var detail in detailList) detail,
            const Divider(),
            if (rate != null) rate,
            if (rate != null) const Divider(),
            for (var link in links) link,
            const Divider(),
            memo,
          ]),
        ),
      ],
    );
  }
}
