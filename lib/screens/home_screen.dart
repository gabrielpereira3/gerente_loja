import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerente_loja/tabs/users_tab.dart';
import '../blocs/orders_bloc.dart';
import '../blocs/user_bloc.dart';
import '../tabs/orders_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int _page = 0;

  UserBloc? _userBloc;
  OrdersBloc? _ordersBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
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
        child: BlocProvider(
          lazy: false,
          create: (_) => UserBloc(),
          child: BlocProvider(
            lazy: false,
            create: (_) => OrdersBloc(),
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _page = page;
                  });
                },
                children: [
                  const UsersTab(),
                  const OrdersTab(),
                  Container(
                    color: Colors.greenAccent,
                  ),
                ],
              ),
          ),
        ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget? _buildFloating() {
    switch (_page) {
      case 0:
        return null;
      case 1:
        return SpeedDial(
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.pinkAccent,
              ),
              backgroundColor: Colors.white,
              label: "Concluídos abaixo",
              labelStyle: const TextStyle(fontSize: 14),
              onTap: () {
                setState(() {
                  _ordersBloc!.setOrderCriteria(SortCriteria.readyLast);
                });
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.pinkAccent,
              ),
              backgroundColor: Colors.white,
              label: "Concluídos acima",
              labelStyle: const TextStyle(fontSize: 14),
              onTap: () {
                setState(() {
                  _ordersBloc!.setOrderCriteria(SortCriteria.readyFirst);
                });
              },
            ),
          ],
          child: const Icon(Icons.sort),
        );
      default:
        return Container();
    }
  }
}
