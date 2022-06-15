import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/widgets/input_field.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginBloc = LoginBloc();


  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch(state){
        case LoginState.success:
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
          break;
        case LoginState.fail:
          showDialog(context: context, builder: (context) => const AlertDialog(
            title: Text("Erro"),
            content: Text("Você não possui os privilégios necessários"),
          ));
          break;
        case LoginState.loading:
        case LoginState.idle:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.loading,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              case LoginState.fail:
              case LoginState.success:
              case LoginState.idle:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Icon(
                              Icons.store_mall_directory,
                              color: Colors.pinkAccent,
                              size: 160,
                            ),
                            InputField(
                              Icons.person_outline,
                              "Usuário",
                              false,
                              _loginBloc.outEmail,
                              _loginBloc.changedEmail,
                            ),
                            InputField(
                              Icons.lock_outline,
                              "Senha",
                              true,
                              _loginBloc.outPassword,
                              _loginBloc.changedPassword,
                            ),
                            const SizedBox(height: 32),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 45,
                                    child: TextButton(
                                      onPressed: snapshot.hasData
                                          ? _loginBloc.submit
                                          : null,
                                      style: ButtonStyle(
                                          backgroundColor: snapshot.hasData
                                              ? MaterialStateProperty.all(
                                                  Colors.pinkAccent)
                                              : MaterialStateProperty.all(Colors
                                                  .pinkAccent
                                                  .withAlpha(140))),
                                      child: const Text(
                                        "Entrar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return Container();
            }
          }),
    );
  }
}
