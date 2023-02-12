import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarURL'] = user.avatarURL;
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final user = ModalRoute.of(context)?.settings.arguments as User;

  //   _loadFormData(user);
  // }

  @override
  Widget build(BuildContext context) {
    //TODO: Fix Expected a Value of Type 'User', but got one of type 'Null'
    final user = ModalRoute.of(context)?.settings.arguments as User;
    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário do Usuário'),
        actions: [
          IconButton(
            onPressed: () {
              final isValid = _form.currentState?.validate();

              if (isValid == true) {
                _form.currentState?.save();

                Provider.of<UsersProvider>(context, listen: false).put(User(
                  id: _formData['id'].toString(),
                  name: _formData['name'].toString(),
                  email: _formData['email'].toString(),
                  avatarURL: _formData['avatarURL'].toString(),
                ));
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome Inválido';
                    }
                  },
                  onSaved: (value) => {
                    _formData['name'] = value!,
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'E-mail Inválido';
                    }
                  },
                  onSaved: (value) => _formData['email'] = value!,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                TextFormField(
                  initialValue: _formData['avatarURL'],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'URL Inválida';
                    }
                  },
                  onSaved: (value) => _formData['avatarURL'] = value!,
                  decoration: const InputDecoration(
                    labelText: 'URL do Avatar',
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
