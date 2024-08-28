import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  static const String routeName = "/";

  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() {
    return _ScreenHomeState();
  }
}

class _ScreenHomeState extends State<ScreenHome>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  late PageController _c;

  @override
  void initState() {
    super.initState();

    _c = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _c.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _c,
        onPageChanged: (newPage) {

        },
        children: const [

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 0,
        iconSize: 24,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        onTap: (index) {
          _c.jumpToPage(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Task",
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}


