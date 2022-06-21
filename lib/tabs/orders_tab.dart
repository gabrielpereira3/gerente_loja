import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import '../widgets/order_tile.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    final ordersBloc = BlocProvider.of<OrdersBloc>(context);

    return Padding(
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return OrderTile(snapshot.data![index]);
                },
              );
            }
          }),
    );
  }
}
