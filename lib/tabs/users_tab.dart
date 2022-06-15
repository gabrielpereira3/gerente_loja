import 'package:flutter/material.dart';

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
                return ListTile(
                  title: Text("teste $index", style: TextStyle(color: Colors.white),),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: 5),
        ),
      ],
    );
  }
}
