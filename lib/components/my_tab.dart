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

  Tab buildTap(int index, String title) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          color: _tabController.index == index ? tabColors[index] : Colors.grey,
        ),
      ),
    );
  }

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
                buildTap(0, 'Note'),
                buildTap(1, 'Todo'),
                buildTap(2, 'Diary'),
                buildTap(3, 'Archiv'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            NoteList(),
            TodoList(),
            DiaryList(),
            ArchiveList(),
          ],
        ),
      ),
    );
  }
}
