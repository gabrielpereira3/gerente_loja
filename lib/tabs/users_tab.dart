import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Pesquisar',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return UserTile();
              },
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.white);
              },
              itemCount: 5),
        ),
      ],
    );
  }
}
