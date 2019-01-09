import 'package:flutter/material.dart';
import '../widgets/folder_item.dart';
import '../screens/folder_screen.dart';

class FolderList extends StatelessWidget {
  final List<FolderItem> _items;

  const FolderList(this._items);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            height: 200.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: _items[index],
                    onTap: () {
                      print('tapped $index');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FolderScreen(_items[index].getFolder())),
                      );
                    },
                  );
                })));
  }
}
