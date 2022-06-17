import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/tabs/users_tab.dart';

import '../blocs/user_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int _page = 0;

  UserBloc? _userBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _userBloc = UserBloc();
  }

  @override
  void dispose() {
    if (_pageController != null) {
      _pageController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pinkAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Clientes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Pedidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Produtos",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _page,
        onTap: (page) {
          _pageController!.animateToPage(
            page,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _page = page;
            });
          },
          children: [
            const UsersTab(),
            Container(
              color: Colors.yellowAccent,
            ),
            Container(
              color: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}
