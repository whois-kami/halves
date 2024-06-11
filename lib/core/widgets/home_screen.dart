import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigatonShell;
  const HomeScreen({
    super.key,
    required this.navigatonShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        currentIndex: navigatonShell.currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage(r'lib\assets\images\home_screens\chat.png'),
              color: Color(0xFF644E9F),
              size: 25,
            ),
            icon: ImageIcon(
              AssetImage(r'lib\assets\images\home_screens\chat.png'),
              color: Colors.white,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage(r'lib\assets\images\home_screens\fire.png'),
              color: Color(0xFF644E9F),
              size: 25,
            ),
            icon: ImageIcon(
              AssetImage(r'lib\assets\images\home_screens\fire.png'),
              color: Colors.white,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage(r'lib\assets\images\home_screens\user.png'),
              color: Color(0xFF644E9F),
              size: 25,
            ),
            icon: ImageIcon(
              AssetImage(r'lib\assets\images\home_screens\user.png'),
              color: Colors.white,
              size: 25,
            ),
            label: '',
          ),
        ],
      ),
      body: navigatonShell,
    );
  }

  void _onTap(BuildContext context, int index) {
    navigatonShell.goBranch(
      index,
      initialLocation: index == navigatonShell.currentIndex,
    );
  }
}
