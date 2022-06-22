import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import '../widgets/order_tile.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {

  bool inverte = false;
  List<DocumentSnapshot> lista = [];

  @override
  Widget build(BuildContext context) {
    final ordersBloc = BlocProvider.of<OrdersBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<List>(
            stream: ordersBloc.outOrders,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "Nenhum pedido encontrado!",
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 25),
                  ),
                );
              } else {
                //lista = snapshot.data! as List<DocumentSnapshot<Object?>>;
                return ListView.builder(
                  reverse: inverte,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return OrderTile(snapshot.data![index]);
                  },
                );
              }
            }),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget? _buildFloating() {
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
              inverte = false;
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
              inverte = true;
            });
          },
        ),
      ],
      child: const Icon(Icons.sort),
    );
  }
}
