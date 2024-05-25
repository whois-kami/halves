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
        currentIndex: navigatonShell.currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Section A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_extinguisher_outlined),
            label: 'Section B',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Section C',
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
