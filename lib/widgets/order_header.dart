import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader(this.order, {Key? key}) : super(key: key);

  final DocumentSnapshot order;

  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.of<UserBloc>(context);

    final _user = _userBloc.getUser(order["clientId"]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${_user["name"]}"),
              Text("${_user["address"]}"),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Produtos: R\$${order["productsPrice"].toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Total R\$${order["totalPrice"].toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
