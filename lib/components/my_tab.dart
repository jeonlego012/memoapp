import 'package:flutter/material.dart';
import 'package:memoapp/screens/1note/note_list.dart';
import 'package:memoapp/screens/2todo/todo_list.dart';
import 'package:memoapp/screens/3diary/diary_list.dart';
import 'package:memoapp/screens/4archive/archive_list.dart';

class MyTab extends StatefulWidget {
  const MyTab({Key? key}) : super(key: key);

  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<Color> tabColors = <Color>[
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            elevation: 0.0,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: tabColors[_tabController.index],
              tabs: [
                Tab(
                  child: Text(
                    'Note',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: _tabController.index == 0
                            ? tabColors[_tabController.index]
                            : Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    'Todo',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: _tabController.index == 1
                            ? tabColors[_tabController.index]
                            : Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    'Diary',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: _tabController.index == 2
                            ? tabColors[_tabController.index]
                            : Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    'Archiv',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: _tabController.index == 3
                            ? tabColors[_tabController.index]
                            : Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            NoteList(),
            Todo(),
            Diary(),
            Archive(),
          ],
        ),
      ),
    );
  }
}
