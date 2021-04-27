import 'Package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/note_detail.dart';

class notelist extends StatefulWidget {
  @override
  _notelistState createState() => _notelistState();
}

class _notelistState extends State<notelist> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Notes')),
        body: getNoteListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('FAB clicked');
            navigateToDetail('Add Note');
          },
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ));
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.headline1;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                  title: Text(
                    'Dummy Title',
                    style: titleStyle,
                  ),
                  subtitle: Text('Dummy Date'),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetail('Edit Note');
                  }));
        });
  }

  void navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title);
    }));
  }
}