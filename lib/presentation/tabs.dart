import 'package:api_study/presentation/pages/home_page.dart';
import 'package:api_study/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';

class BottomTabs {
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget tab;
  final IconData unselectedIcon;
  final IconData selectedIcon;

  BottomTabs({
    required this.title,
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.tab,
    required this.navigatorKey,
  });
}

final Set<BottomTabs> mainSections = {
  BottomTabs(
    tab: const HomePage(),
    title: 'Home',
    unselectedIcon: Icons.home_rounded,
    selectedIcon: Icons.home_rounded,
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
  BottomTabs(
    tab: const SearchPage(),
    title: 'Pesquisar',
    unselectedIcon: Icons.search,
    selectedIcon: Icons.search,
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
};

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentTab = mainSections.toList()[_currentTabIndex];
    return WillPopScope(
      onWillPop: () async =>
          !await currentTab.navigatorKey.currentState!.maybePop(),
      child: Scaffold(
        body: Material(
          child: IndexedStack(
            index: _currentTabIndex,
            children: mainSections
                .map(
                  _buildIndexedPageTab,
                )
                .toList(),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[900]!,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.purple[900],
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: mainSections
                .map(
                  (mainNavigationTab) => BottomNavigationBarItem(
                    label: mainNavigationTab.title,
                    icon: Icon(mainNavigationTab.unselectedIcon),
                    activeIcon: Icon(mainNavigationTab.selectedIcon),
                  ),
                )
                .toList(),
            currentIndex: _currentTabIndex,
            onTap: (newIndex) => setState(
              () => _currentTabIndex != newIndex
                  ? _currentTabIndex = newIndex
                  : currentTab.navigatorKey.currentState!
                      .popUntil((route) => route.isFirst),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndexedPageTab(BottomTabs mainSection) {
    return Navigator(
      key: mainSection.navigatorKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (context) => mainSections.toList()[_currentTabIndex].tab,
      ),
    );
  }
}
