import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('TMDB')),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: const [
          Text(
            'Новости',
          ),
          MovieListWidget(),
          Text(
            'Сериалы',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Новости'),
          BottomNavigationBarItem(
            label: 'Фильмы',
            icon: Icon(Icons.movie_filter),
          ),
          BottomNavigationBarItem(
            label: 'Сериалы',
            icon: Icon(Icons.tv),
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
