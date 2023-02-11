import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário do Usuário'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            child: Column(
          children: <Widget>[TextFormField()],
        )),
      ),
    );
  }
}
