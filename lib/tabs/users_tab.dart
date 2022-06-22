import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerente_loja/widgets/user_tile.dart';
import '../blocs/user_bloc.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Pesquisar',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            onChanged: userBloc.onChangedSearch,
          ),
        ),
        Expanded(
          child: StreamBuilder<List>(
              stream: userBloc.outUsers,
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
                      "Nenhum usuário encontrado!",
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 25),
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(snapshot.data![index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.white);
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
              }),
        ),
      ],
    );
  }
}
