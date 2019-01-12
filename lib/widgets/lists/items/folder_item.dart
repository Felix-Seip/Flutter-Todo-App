import 'package:flutter/material.dart';
import '../../../classes/folder.dart';

class FolderItem extends StatelessWidget {
  const FolderItem(this._folder);

  final Folder _folder;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        child:
            Text(_folder.getTitle(), style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.5, color: Colors.white),),
        alignment: Alignment.center,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          image: DecorationImage(
              image: AssetImage("assets/wallpaper.jpg"), fit: BoxFit.cover)),
      width: 250.0,
      margin: EdgeInsets.all(20.0),
    );
  }

  Folder getFolder(){
    return _folder;
  }
}
