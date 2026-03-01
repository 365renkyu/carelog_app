import 'package:flutter/material.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/router/app_router.dart';
import 'package:ikuji_kiroku_app/core/theme/app_theme.dart';
import 'package:ikuji_kiroku_app/features/calendar/calendar_screen.dart';
import 'package:ikuji_kiroku_app/features/export/export_screen.dart';
import 'package:ikuji_kiroku_app/features/settings/settings_screen.dart';
import 'package:ikuji_kiroku_app/shared/widgets/child_info_header.dart';

/*
・設定タブの書き方可読性向上させる（数値が何を表しているのかわかりづらい）

*/
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    CalendarScreen(),
    ExportScreen(),
    SettingsScreen(),
  ];

  static const _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      activeIcon: Icon(Icons.calendar_month),
      label: AppStrings.navCalendar,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.ios_share_outlined),
      activeIcon: Icon(Icons.ios_share),
      label: AppStrings.navExport,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: AppStrings.navSettings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 設定タブ以外にChildInfoHeaderを表示
          if (_index != 2) const ChildInfoHeader(),
          Expanded(
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: IndexedStack(index: _index, children: _screens)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
      ),
    );
  }
}
