import 'package:coffee_life_manager/ui/page/theme_selector/theme_selector_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('テーマを変更する'),
            onTap: () async {
              await Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) {
                    return ThemeSelectorPage();
                  },
                ),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('ライセンス'),
            onTap: () {
              // TODO: アプリケーションの名前などを追加
              showLicensePage(context: context);
            },
          ),
        ],
      ),
    );
  }
}
