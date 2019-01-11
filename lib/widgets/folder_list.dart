import 'package:flutter/material.dart';
import '../widgets/folder_item.dart';
import '../screens/folder_screen.dart';

class FolderList extends StatefulWidget {
  final List<FolderItem> _items;

  const FolderList(this._items);

  @override
  State<StatefulWidget> createState() {
    return _FolderListState();
  }
}

class _FolderListState extends State<FolderList> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget._items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: widget._items[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FolderScreen(widget._items[index].getFolder())),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
