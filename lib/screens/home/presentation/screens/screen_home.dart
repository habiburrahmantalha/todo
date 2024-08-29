import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/home/presentation/blocs/home_cubit.dart';
import 'package:todo/screens/home/settings/presentation/pages/page_settings.dart';
import 'package:todo/screens/home/task_list/presentation/pages/page_task_list.dart';



class ScreenHome extends StatefulWidget {
  static const String routeName = "/";

  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() {
    return _ScreenHomeState();
  }
}

class _ScreenHomeState extends State<ScreenHome> {

  // @override
  // bool get wantKeepAlive => true;

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
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _c,
              onPageChanged: (newPage) {
                context.read<HomeCubit>().setSelectedTab(newPage);
              },
              children: const [
                PageTaskList(),
                PageSettings()
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: state.selectedTab ?? 0,
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
        },
      ),
    );
  }
}


