import 'package:flutter/material.dart';
import 'package:handball_ergebnisse/pages/associations/associations.dart';
import 'package:handball_ergebnisse/pages/home/widgets/favorite_leagues_overview.dart';
import 'package:handball_ergebnisse/pages/seasons/seasons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    FavoriteLeaguesOverview(),
    Center(child: Text("Zur Zeit leider noch nicht verügbar."))
  ];
  final navigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today_outlined),
      label: "Meine Ligen",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: "Meine Teams",
    ),
  ];

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Handball Ergebnisse"),
      ),
      body: pages.elementAt(currentTab),
      bottomNavigationBar: BottomNavigationBar(
        items: navigationBarItems,
        currentIndex: currentTab,
        onTap: (tabNumber) => setState(() => currentTab = tabNumber),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddLeague(context),
        tooltip: 'Liga hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }

  void _openAddLeague(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeasonsPage()),
    );
  }
}
