import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile(this.user, {Key? key}) : super(key: key);

  final Map<String, dynamic> user;

  final textStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    
    if(user.containsKey("money")){
      return ListTile(
        title: Text(user["name"], style: textStyle),
        subtitle: Text(user["email"], style: textStyle),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Pedidos: ${user["orders"]}", style: textStyle),
            Text("Gastos: R\$${user["money"].toStringAsFixed(2)}", style: textStyle),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
